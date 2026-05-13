import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
import 'package:url_launcher/url_launcher.dart';

class ProfileViewModel extends BaseViewModel {
  ProfileViewModel();

  final updateKey = GlobalKey<FormState>();
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

  bool get hasValidDeliveryAddress {
    if (addresses.isEmpty) return false;

    final addr = defaultAddress;
    if (addr == null) return false;

    return (addr.streetAddress?.trim().isNotEmpty ?? false) ||
        (addressMain.isNotEmpty && addressMain != 'N/A');
  }

  bool get hasValidPhoneNumber {
    final phone = phoneNumber.trim();
    return phone.isNotEmpty && phone.length >= 10;
  }

  bool get isProfileCompleteForCheckout =>
      hasValidDeliveryAddress && hasValidPhoneNumber;

  String? get missingProfileInfo {
    final List<String> missing = [];
    if (!hasValidDeliveryAddress) missing.add("Delivery Address");
    if (!hasValidPhoneNumber) missing.add("Phone Number");

    if (missing.isEmpty) return null;
    return "Click to update your ${missing.join(" and ")} to proceed with checkout.";
  }

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
      case 'prepared' || 'processing':
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

  // THIRD-PARTY GEOCODING SERVICE FOR WEB
  // Using Nominatim (OpenStreetMap) - Free, no API key required
  Future<String> _getAddressFromCoordinatesWeb(
    double latitude,
    double longitude,
  ) async {
    try {
      // Nominatim API (OpenStreetMap) - Free tier
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1',
      );

      final response = await http.get(
        url,
        headers: {
          'User-Agent': 'QueenPlateDelivery/1.0 (your-email@example.com)',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final address = data['display_name'] as String?;

        if (address != null && address.isNotEmpty) {
          return address;
        }
      }

      // Fallback to coordinates if API fails
      return "Location: ${latitude.toStringAsFixed(4)}, ${longitude.toStringAsFixed(4)}";
    } catch (e) {
      debugPrint("Web geocoding error: $e");
      // Fallback to coordinates
      return "Location: ${latitude.toStringAsFixed(4)}, ${longitude.toStringAsFixed(4)}";
    }
  }

  // ALTERNATIVE: Google Maps Geocoding API (requires API key)
  // Uncomment and add your API key if you prefer Google
  /*
  Future<String> _getAddressFromCoordinatesWebGoogle(
    double latitude,
    double longitude,
  ) async {
    try {
      const apiKey = 'YOUR_GOOGLE_MAPS_API_KEY'; // Add your API key here
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          return data['results'][0]['formatted_address'];
        }
      }
      
      return "Location: ${latitude.toStringAsFixed(4)}, ${longitude.toStringAsFixed(4)}";
    } catch (e) {
      debugPrint("Google geocoding error: $e");
      return "Location: ${latitude.toStringAsFixed(4)}, ${longitude.toStringAsFixed(4)}";
    }
  }
  */

  // ENHANCED METHOD - Handles Web and Mobile with third-party service for Web
  Future<void> getCurrentDeliveryAddress() async {
    if (_isGettingLocation) return;

    _isGettingLocation = true;
    deliveryAddress = "Requesting location access...";
    notifyListeners();

    try {
      // ==================== LOCATION PERMISSION ====================
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        deliveryAddress = kIsWeb
            ? "Location access denied.\nPlease allow location permission in your browser settings."
            : "Location permission denied.\nPlease enable it in your device settings.";
        _isGettingLocation = false;
        notifyListeners();
        return;
      }

      // ==================== CHECK LOCATION SERVICE (Mobile only) ====================
      if (!kIsWeb) {
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          deliveryAddress = "Please enable location services on your device.";
          _isGettingLocation = false;
          notifyListeners();
          return;
        }
      }

      // ==================== GET COORDINATES ====================
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      // ==================== REVERSE GEOCODING (Platform-specific) ====================
      if (kIsWeb) {
        // WEB: Use third-party geocoding service
        deliveryAddress = await _getAddressFromCoordinatesWeb(
          position.latitude,
          position.longitude,
        );
      } else {
        // MOBILE: Use device location service and geocoding package
        final List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          final Placemark place = placemarks[0];
          String address =
              "${place.street ?? ''}, ${place.locality ?? ''}, "
              "${place.administrativeArea ?? ''}, ${place.country ?? ''}";

          // Clean up the address string
          address = address
              .replaceAll(RegExp(r', ,'), ',')
              .replaceAll(RegExp(r', $'), '')
              .trim();

          deliveryAddress = address.isNotEmpty
              ? address
              : "${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}";
        } else {
          // Fallback to coordinates if no address found
          deliveryAddress =
              "${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}";
        }
      }
    } catch (e) {
      debugPrint("Location error: $e");

      deliveryAddress = kIsWeb
          ? "Unable to get location.\nPlease ensure location access is allowed in your browser."
          : "Unable to get location. Please check your device settings.";
    } finally {
      _isGettingLocation = false;
      notifyListeners();
    }
  }

  // Helper method to open location in map (useful for web)
  Future<void> openLocationInMap(double latitude, double longitude) async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      AppUiComponents.triggerNotification("Could not open maps", error: true);
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
