import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:flutter/material.dart';
import 'package:queen_plate_delivery/common/AppUtils/app_ui_components.dart';
import 'package:queen_plate_delivery/common/appmanager/shared_preferences.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/main_core/app.logger.dart';
import 'package:queen_plate_delivery/core/main_core/app.router.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
import 'package:queen_plate_delivery/screens/auth/model/get_user_res_model.dart';
import 'package:queen_plate_delivery/screens/auth/repository/auth_repo_impl.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/get_all_user_review_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/order_status_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/send_review_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/send_review_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/update_user_profile.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/update_user_profile_res.dart';
import 'package:queen_plate_delivery/screens/dashboard/repo/general_repo_impl.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/sub_model.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  ProfileViewModel();
  void editProfile() {
    // Navigate to edit profile screen
  }

  // Add these properties
  List<OrderModel> orders = [];

  bool isViewingReviews = false; // Toggle between Give Feedback & View Reviews
  int selectedRating = 0;

  bool? _isLoading;
  bool? get isLoading => _isLoading;

  final logger = getLogger("ProfileViewModel");

  final session = locator<SharedPreferencesService>();
  final authRepo = locator<AuthRepoImpl>();
  final userRepo = locator<GeneralRepoImpl>();

  String get name => session.usersData["user"]?["name"] ?? '';
  String get email => session.usersData["user"]?["email"] ?? '';
  String get userId => (session.usersData["user"]?["id"] ?? '').toString();

  List<AddressModel> get addresses {
    final raw = session.usersData["addresses"];
    if (raw == null || raw is! List) return [];
    return List<Map<String, dynamic>>.from(
      raw,
    ).map((e) => AddressModel.fromJson(e)).toList();
  }

  // Default address helpers
  AddressModel? get defaultAddress => addresses.isNotEmpty
      ? addresses.firstWhere(
          (a) => a.isDefault == 1,
          orElse: () => addresses.first,
        )
      : null;

  String get addressMain => defaultAddress?.streetAddress ?? 'N/A';
  String get apartmentSuite => defaultAddress?.apartmentSuite ?? 'N/A';
  String get phoneNumber => defaultAddress?.phoneNumber ?? '';
  String get addressState => defaultAddress?.state ?? 'N/A';
  String get addressCountry => defaultAddress?.country ?? 'N/A';

  Future<void> logout() async {
    try {
      SharedPreferencesService.instance.isLoggedIn = false;
      SharedPreferencesService.instance.logOut();
      PageRouter.pushReplacement(Routes.loginView);
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      AppUiComponents.triggerNotification(e.toString(), error: true);
    }
    notifyListeners();
  }

  GetUserResModel? _getUser;
  GetUserResModel? get getUser => _getUser;
  Future<void> fetchUser() async {
    try {
      _isLoading = true;
      _getUser = await runBusyFuture(
        authRepo.getUser(),
        throwException: true,
        busyObject: false,
      );
      _isLoading = false;
      session.usersData = _getUser!.data!.toJson();
    } catch (e) {
      _isLoading = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
    }
  }

  // Model Class (Add this inside the same file or create a new model file)
  void copyToClipboard(BuildContext context, String text) {
    // You can use Clipboard.setData from flutter/services
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$text copied"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Track User Order Status
  OrderStatusResModel? _orderStatusModel;
  OrderStatusResModel? get orderStatusModel => _orderStatusModel;
  // Add this method to map order status to tracking steps
  List<TrackingStep> _buildTrackingStepsFromStatus(String? status) {
    final steps = [
      TrackingStep(
        title: "Order received",
        subtitle: "Restaurant confirmed your delivery",
        icon: Icons.check_circle,
      ),
      TrackingStep(
        title: "Being prepared",
        subtitle: "Chef is preparing your food",
        icon: Icons.restaurant,
      ),
      TrackingStep(
        title: "Ready for Pick-Up",
        subtitle: "Ready to get Delivered to you",
        icon: CupertinoIcons.gift,
      ),
      TrackingStep(
        title: "Out for delivery",
        subtitle: "Rider on the way",
        icon: Icons.delivery_dining,
      ),
      TrackingStep(
        title: "Delivered",
        subtitle: "Kindly enjoy your meal",
        icon: Icons.home,
        isLast: true,
      ),
    ];

    int completedIndex = -1;
    switch (status?.toLowerCase()) {
      case 'received' || 'pending':
        completedIndex = 0;
        break;
      case 'prepared':
        completedIndex = 1;
        break;
      case 'ready_for_pick':
        completedIndex = 2;
        break;
      case 'out_for_delivery':
        completedIndex = 3;
        break;
      case 'delivered':
        completedIndex = 4;
        break;
      default:
        completedIndex = -1;
    }

    return steps.asMap().entries.map((entry) {
      final index = entry.key;
      final step = entry.value;
      return TrackingStep(
        title: step.title,
        subtitle: step.subtitle,
        icon: step.icon,
        isCompleted: index <= completedIndex,
        isLast: step.isLast,
      );
    }).toList();
  }

  List<TrackingStep> trackingSteps = [];
  // Modify trackOrderStatus to update trackingSteps and estimatedTime
  Future<void> trackOrderStatus(String orderId) async {
    try {
      _orderStatusModel = await runBusyFuture(
        userRepo.getOrderStatus(orderId),
        throwException: true,
      );
      // Update tracking steps from API status
      final status =
          _orderStatusModel?.data?.status; // adjust based on actual model
      trackingSteps = _buildTrackingStepsFromStatus(status);
      // stopOrderTracking();
      notifyListeners();
    } catch (e) {
      logger.d(e.toString());
      AppUiComponents.triggerNotification(
        "Error Getting Order Status, Retry",
        error: true,
      );
      notifyListeners();
    }
  }

  // Optional: start periodic polling (remove old simulation)
  Timer? _statusTimer;

  void startOrderTracking(String orderId) {
    // Do not use simulated steps; fetch immediately and then poll
    trackOrderStatus(orderId);
    _statusTimer?.cancel();
    _statusTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      await trackOrderStatus(orderId);
      // Stop polling when delivered
      if (_orderStatusModel?.data?.status?.toLowerCase() == 'delivered') {
        _statusTimer?.cancel();
        _statusTimer = null;
      } else if (_orderStatusModel?.data?.status?.toLowerCase() ==
          'cancelled') {
        _statusTimer?.cancel();
        _statusTimer = null;
      }
    });
  }

  void stopOrderTracking() {
    _statusTimer?.cancel();
    _statusTimer = null;
  }

  bool? _isLoad;
  bool? get isLoad => _isLoad;

  UpdateUserProfileResModel? _updateUser;
  UpdateUserProfileResModel? get updateUser => _updateUser;
  Future<void> updateProfile(UpdateUserProfile user) async {
    try {
      _isLoad = true;
      _updateUser = await runBusyFuture(
        userRepo.updateUserProfile(user),
        throwException: true,
      );
      _isLoad = false;
      if (_updateUser?.success != false) {
        PageRouter.pushReplacement(Routes.dashboardView);
        AppUiComponents.triggerNotification(
          "Updated Successfully",
          error: false,
        );
        await fetchUser();
      }
      notifyListeners();
    } catch (e) {
      _isLoad = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
    }
  }

  String deliveryAddress = "Fetching your location...";
  bool _isGettingLocation = false;

  // Improved Method - Shows permission request on BOTH Mobile and Web
  Future<void> getCurrentDeliveryAddress() async {
    if (_isGettingLocation) return;

    _isGettingLocation = true;
    deliveryAddress = "Requesting location access..."; // Clear feedback
    notifyListeners();

    try {
      Position position;

      // ==================== COMMON PERMISSION REQUEST ====================
      // This works on both Mobile and Web
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission =
            await Geolocator.requestPermission(); // ← This triggers the prompt
      }

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        deliveryAddress = kIsWeb
            ? "Location access denied.\nPlease allow location permission in your browser settings."
            : "Location permission denied.\nPlease enable it in your device settings.";
        return;
      }

      // ==================== GET POSITION (Platform Specific) ====================
      if (!kIsWeb) {
        // Mobile only: Check if location service is enabled
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          deliveryAddress = "Please enable location services on your device.";
          return;
        }
      }

      // Get current position (this works on both platforms)
      position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      // ==================== REVERSE GEOCODING ====================
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        String address =
            "${place.street ?? ''}, ${place.locality ?? ''}, "
                    "${place.administrativeArea ?? ''}, ${place.country ?? ''}"
                .replaceAll(RegExp(r', ,'), ',')
                .replaceAll(RegExp(r', $'), '')
                .trim();

        if (address.endsWith(',')) {
          address = address.substring(0, address.length - 1);
        }

        deliveryAddress = address.isNotEmpty
            ? address
            : "${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}";
      } else {
        // Fallback to coordinates
        deliveryAddress =
            "${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}";
      }
    } catch (e) {
      debugPrint("Location error: $e");

      deliveryAddress = kIsWeb
          ? "Unable to get location.\nPlease allow location access when prompted by your browser."
          : "Unable to get location. Please check your device settings.";
    } finally {
      _isGettingLocation = false;
      notifyListeners();
    }
  }

  // Send User Feedback
  SendReviewResModel? _sendFeedback;
  SendReviewResModel? get sendFeedback => _sendFeedback;
  Future<void> submitFeedback(
    SendReviewModel model,
    BuildContext context,
  ) async {
    try {
      _isLoad = true;
      _sendFeedback = await runBusyFuture(
        userRepo.sendFeedBack(model),
        throwException: true,
      );
      _isLoad = false;
      if (_sendFeedback!.success != false) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Review Submitted Successfully!")),
        );
        await getAllFeeback();
        PageRouter.pop();
      }
    } catch (e) {
      _isLoad = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
    }
  }

  // Get All Logged in User Feedback
  GetAllUserReviewModel? _allFeedback;
  GetAllUserReviewModel? get allFeedback => _allFeedback;
  Future<void> getAllFeeback() async {
    try {
      _isLoad = true;
      _allFeedback = await runBusyFuture(
        userRepo.getUserReviews(),
        throwException: true,
      );
      _isLoad = false;
    } catch (e) {
      _isLoad = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
    }
  }
}
