import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/common/AppUtils/app_ui_components.dart';
import 'package:queen_plate_delivery/common/Button/ButtonWidget.dart';
import 'package:queen_plate_delivery/common/Button/Model/ButtonConfig.dart';
import 'package:queen_plate_delivery/common/Gap.dart';
import 'package:queen_plate_delivery/common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/common/TextView/TextView.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/main_core/app.logger.dart';
import 'package:queen_plate_delivery/core/main_core/app.router.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
import 'package:queen_plate_delivery/screens/auth/model/get_user_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/add_cart_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/add_cart_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/checkout_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/checkout_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/list_cart_item_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/menu_detail_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/menu_list_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/order_history_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/update_quantity_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/update_quantity_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/repo/general_repo_impl.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/dashboard_view_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/profile_view_model.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

DateTime? _lastMenuFetchTime;

class CartViewModel extends ProfileViewModel {
  CartViewModel();
  String? _customDeliveryAddress;
  String? get customDeliveryAddress => _customDeliveryAddress;
  final _profileViewModel = locator<ProfileViewModel>();

  bool get isProfileReadyForCheckout =>
      _profileViewModel.isProfileCompleteForCheckout;
  String? get profileCompletionMessage => _profileViewModel.missingProfileInfo;

  @override
  List<AddressModel> get addresses => _profileViewModel.addresses;

  void setDeliveryAddress(String address) {
    _customDeliveryAddress = address;
    notifyListeners();
  }

  int quantity = 1;

  // ====================== INCREASE QUANTITY ======================
  Future<void> detailIncrease(String? cartItemId, String? mainFoodId) async {
    final cartDetails = menuDetail?.data?.cartDetails;

    if (cartDetails != null && cartItemId != null && cartItemId.isNotEmpty) {
      // Item already in cart → Update on backend
      await updateFoodCartItem(
        UpdateQuantityModel(type: "increase"),
        cartItemId,
      );
    } else {
      // Item not in cart → Increase local quantity
      quantity++;
    }

    // Always refresh menu detail to get latest data from server
    if (mainFoodId != null && mainFoodId.isNotEmpty) {
      await fetchMenuDetail(mainFoodId);
    } else {
      notifyListeners();
    }
  }

  // ====================== DECREASE QUANTITY ======================
  Future<void> detailDecrease(String? cartItemId, String? mainFoodId) async {
    final cartDetails = menuDetail?.data?.cartDetails;

    if (cartDetails != null && cartItemId != null && cartItemId.isNotEmpty) {
      // Item already in cart
      final currentQty = int.tryParse(cartDetails.quantity ?? '0') ?? 0;

      if (currentQty > 1) {
        await updateCartItem(UpdateQuantityModel(type: "decrease"), cartItemId);
      } else if (currentQty == 1) {
        await deleteCartItem(cartItemId);
      }
    } else {
      // Item not in cart → decrease local quantity (minimum 1)
      if (quantity > 1) {
        quantity--;
      }
    }

    // Always refresh to sync with backend
    if (mainFoodId != null && mainFoodId.isNotEmpty) {
      await fetchMenuDetail(mainFoodId);
    } else {
      notifyListeners();
    }
  }

  String selectedPaymentMethod = "";
  bool? _isLoad;
  @override
  bool? get isLoad => _isLoad;

  final stt.SpeechToText _speech = stt.SpeechToText();

  String searchQuery = "";
  int? selectedCategoryId;
  String? selectedCategoryName = "All Meals";
  bool isListening = false;

  Future<void> initializeSpeech() async {
    try {
      final available = await _speech.initialize(
        onError: (error) => print("Speech Error: $error"),
        onStatus: (status) => print("Speech Status: $status"),
      );
      print("Speech recognition available: $available");
    } catch (e) {
      print("Failed to initialize speech: $e");
    }
  }

  void toggleVoiceSearch() async {
    if (isListening) {
      _stopListening();
    } else {
      _startListening();
    }
  }

  Future<void> _startListening() async {
    try {
      bool available = await _speech.initialize();
      if (!available) {
        print("Speech recognition not available on this device");
        return;
      }

      isListening = true;
      notifyListeners();

      await _speech.listen(
        onResult: (result) {
          updateSearchQuery(result.recognizedWords);
          if (result.finalResult) {
            Future.delayed(const Duration(milliseconds: 500), () {
              _stopListening();
            });
          }
        },
        listenFor: const Duration(seconds: 15),
        localeId: "en_US",
      );
    } catch (e) {
      print("Error starting speech: $e");
      isListening = false;
      notifyListeners();
    }
  }

  void _stopListening() {
    _speech.stop();
    isListening = false;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    searchQuery = query.trim();
    notifyListeners();
  }

 void selectCategory(int? categoryId) {
  selectedCategoryId = categoryId;

  if (categoryId == null) {
    selectedCategoryName = "All Meals";
  } else {
    final category = menuList?.data?.categories.firstWhere(
      (cat) => cat.id == categoryId,
      orElse: () => throw Exception(), // safer
    );
    selectedCategoryName = category?.name ?? "Meals";
  }

  notifyListeners();
}

  // Add this method
  void selectPaymentMethod(String method) {
    selectedPaymentMethod = method;
    notifyListeners();
  }

  // Add this method
  void placeOrder() {
    if (selectedPaymentMethod.isEmpty) return;

    // Your order placement logic here
    print("Order placed using $selectedPaymentMethod");
    // You can navigate to success screen, show dialog, etc.
  }

  void showAddToCartSuccessBottomSheet(
    BuildContext context, {
    required String foodName,
    required num quantity,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: AppColors.green, // or your success color
                size: 60,
              ),
              Gap(height: 16),
              TextView(
                config: TextViewConfig(
                  text: "Added to Cart!",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gap(height: 8),
              TextView(
                config: TextViewConfig(
                  text: "$quantity x $foodName has been added to your cart",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(height: 32),

              // View Cart Button
              ButtonWidget(
                config: ButtonConfig(
                  text: "View Cart",
                  fontWeight: FontWeight.w600,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    locator<DashboardViewModel>().setIndex(2);
                  },
                  height: 56,
                  radius: 12.r,
                  buttonColor: AppColors.primary,
                  textColor: Colors.white,
                ),
              ),

              Gap(height: 12),

              // Continue Shopping Button
              ButtonWidget(
                config: ButtonConfig(
                  text: "Continue Shopping",
                  fontWeight: FontWeight.w600,
                  onPressed: () {
                    Navigator.pop(context);
                    PageRouter.pop();
                  },
                  height: 56,
                  radius: 12.r,
                  buttonColor: AppColors.primary,
                  textColor: Colors.white,
                ),
              ),

              Gap(height: 16),
            ],
          ),
        );
      },
    );
  }

  void addToCart({
    required String foodName,
    required String price,
    required int quantity,
    required String imageUrl,
    required AddCartModel model,
    required BuildContext context,
  }) {
    // AppUiComponents.triggerNotification(
    //   "Added $quantity x $foodName to cart",
    //   error: false,
    // );
    sendToCart(model, foodName, context);
    notifyListeners();

    // Optional: Show snackbar
    // You can access context via a service or pass it if needed
  }

  // Reset quantity when leaving screen (optional)
  void resetQuantity() {
    quantity = 1;
    notifyListeners();
  }

  @override
  // ignore: overridden_fields
  final logger = getLogger("CartViewModel");

  final cartRepo = locator<GeneralRepoImpl>();
  AddCartResModel? _cartAdd;
  AddCartResModel? get cartAdd => _cartAdd;
  Future<void> sendToCart(
    AddCartModel cartModel,
    String foodName,
    BuildContext context,
  ) async {
    try {
      _isLoad = true;
      _cartAdd = await runBusyFuture(
        cartRepo.addToCart(cartModel),
        throwException: true,
        busyObject: false,
      );
      _isLoad = false;
      notifyListeners();
      // ignore: unrelated_type_equality_checks
      if (_cartAdd?.success == true || _cartAdd?.status != false) {
        // Show success bottom sheet or dialog
        showAddToCartSuccessBottomSheet(
          context,
          foodName: foodName,
          quantity: cartModel.quantity ?? 1,
        );
      } else {
        AppUiComponents.triggerNotification(
          _cartAdd?.message ?? "Failed to add to cart",
          error: true,
        );
      }
      await fetchMenuDetail(cartModel.foodItemId.toString());
    } catch (e) {
      _isLoad = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
      notifyListeners();
    }
  }

  MenuListResModel? _menuList;
  MenuListResModel? get menuList => _menuList;
  // Replace your current fetchMenu with this:
  Future<void> fetchMenu({bool forceRefresh = false}) async {
    final now = DateTime.now();

    // Skip API call if we have fresh cache (2 minutes)
    if (!forceRefresh &&
        _menuList != null &&
        _lastMenuFetchTime != null &&
        now.difference(_lastMenuFetchTime!).inMinutes < 2) {
      return;
    }

    try {
      _isLoad = true;
      notifyListeners();

      _menuList = await runBusyFuture(cartRepo.getMenu(), throwException: true);

      _lastMenuFetchTime = now;
      notifyListeners();
    } catch (e) {
      _isLoad = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
    } finally {
      _isLoad = false;
      notifyListeners();
    }
  }

  // Function to Get Menu Details
  MenuDetailResModel? _menuDetail;
  MenuDetailResModel? get menuDetail => _menuDetail;
  Future<void> fetchMenuDetail(String foodid) async {
    try {
      _isLoad = true;
      _menuDetail = await runBusyFuture(
        cartRepo.getMenuDetail(foodid),
        throwException: true,
      );
      _isLoad = false;
      notifyListeners();
    } catch (e) {
      _isLoad = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
      notifyListeners();
    }
  }

  // Add these properties in your CartViewModel class0
  ListCartResModel? _cartResModel;
  ListCartResModel? get cartResModel => _cartResModel;

  DateTime? _lastFetchTime;
  bool _hasCachedData = false;

  bool get hasCachedCartData => _hasCachedData && _cartResModel != null;

  // Improved Fetch with better caching
  Future<void> fetchCartItem({bool forceRefresh = false}) async {
    final now = DateTime.now();

    // Skip API call if we have fresh cache (30 seconds)
    if (!forceRefresh &&
        _hasCachedData &&
        _lastFetchTime != null &&
        now.difference(_lastFetchTime!).inSeconds < 30) {
      return;
    }

    try {
      _isLoad = true;
      notifyListeners();

      _cartResModel = await runBusyFuture(
        cartRepo.listCartItem(),
        throwException: true,
      );

      _lastFetchTime = now;
      _hasCachedData = true;

      _isLoad = false;
      notifyListeners();
    } catch (e) {
      _isLoad = false;
      notifyListeners();
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
    }
  }

  Future<void> refreshCart() async {
    await fetchCartItem(forceRefresh: true);
  }

  void clearCartCache() {
    _cartResModel = null;
    _hasCachedData = false;
    _lastFetchTime = null;
    notifyListeners();
  }

  // === FIXED QUANTITY METHODS ===
  Future<void> increaseQuantity(String itemId) async {
    final currentItem = _cartResModel?.data?.items.firstWhere(
      (item) => item.id.toString() == itemId,
      orElse: () => throw Exception(),
    );

    if (currentItem == null) return;

    final newQuantity =
        (int.tryParse(currentItem.quantity.toString()) ?? 0) + 1;

    await updateCartItem(UpdateQuantityModel(type: "increase"), itemId);
  }

  Future<void> decreaseQuantity(String itemId) async {
    final currentItem = _cartResModel?.data?.items.firstWhere(
      (item) => item.id.toString() == itemId,
      orElse: () => throw Exception(),
    );

    if (currentItem == null) return;

    final currentQty = int.tryParse(currentItem.quantity.toString()) ?? 1;

    if (currentQty > 1) {
      final newQuantity = currentQty - 1;
      await updateCartItem(UpdateQuantityModel(type: "decrease"), itemId);
    } else {
      await deleteCartItem(itemId);
    }
  }

  // Function to Delete an Item from Cart
  AddCartResModel? _removeItem;
  AddCartResModel? get removeItem => _removeItem;
  Future<void> deleteCartItem(String foodid) async {
    try {
      _isLoad = true;
      _removeItem = await runBusyFuture(
        cartRepo.removeCartItem(foodid),
        throwException: true,
      );
      _isLoad = false;
      await fetchCartItem(forceRefresh: true);
      notifyListeners();
    } catch (e) {
      _isLoad = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
      notifyListeners();
    }
  }

  // Function to Checkout Customer according to payment Method
  CheckoutResModel? _checkResModel;
  CheckoutResModel? get checkResModel => _checkResModel;

  Future<void> makePayment(CheckoutModel model) async {
    try {
      _isLoad = true;
      notifyListeners();

      _checkResModel = await runBusyFuture(
        cartRepo.checkoutUser(model),
        throwException: true,
        busyObject: false,
      );

      if (_checkResModel?.data?.paymentUrl != null) {
        // Open In-App WebView
        _openPaymentWebView(
          _checkResModel!.data!.paymentUrl!,
          _checkResModel!.data!.orderId!,
          model.deliveryAddress!,
        );
      }

      _isLoad = false;
      notifyListeners();
    } catch (e) {
      _isLoad = false;
      notifyListeners();
      AppUiComponents.triggerNotification(e.toString(), error: true);
    }
  }

  // New Method: Open Payment in In-App Browser
  void _openPaymentWebView(String paymentUrl, String orderId, String address) {
    PageRouter.pushNamed(
      Routes.paystackWebView,
      args: PaystackWebViewArguments(
        paymentUrl: paymentUrl,
        onPaymentCancelled: () {
          AppUiComponents.triggerNotification("Payment Cancelled", error: true);
        },
        onPaymentSuccess: (reference) {
          // Navigate to success screen
          PageRouter.pop();
          PageRouter.pushNamed(
            Routes.orderSuccessView,
            args: OrderSuccessViewArguments(orderId: orderId, address: address),
          );
        },
        orderId: orderId,
      ),
    );
  }

  // This function update Food Item in Cart from the Detail Screen
  UpdateQuantityResModel? _updateItemQuantity;
  UpdateQuantityResModel? get updateItemQuantity => _updateItemQuantity;
  Future<void> updateFoodCartItem(
    UpdateQuantityModel model,
    String itemId,
  ) async {
    try {
      _isLoad = true;
      _updateItemQuantity = await runBusyFuture(
        cartRepo.updateCartitem(model, itemId),
        throwException: true,
      );
      _isLoad = false;
      notifyListeners();
    } catch (e) {
      _isLoad = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
      notifyListeners();
    }
    notifyListeners();
  }

  UpdateQuantityResModel? _updateQuantity;
  UpdateQuantityResModel? get updateQuantity => _updateQuantity;
  Future<void> updateCartItem(UpdateQuantityModel model, String itemId) async {
    try {
      _isLoad = true;
      _updateQuantity = await runBusyFuture(
        cartRepo.updateCartitem(model, itemId),
        throwException: true,
      );
      _isLoad = false;
      await fetchCartItem(forceRefresh: true);
      notifyListeners();
    } catch (e) {
      _isLoad = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
      notifyListeners();
    }
    notifyListeners();
  }

  OrderHistoryResModel? _orderHistory;
  OrderHistoryResModel? get orderHistory => _orderHistory;
  Future<void> fetchOrderHistory() async {
    try {
      _orderHistory = await runBusyFuture(
        cartRepo.getOrderHistory(),
        throwException: true,
      );
      notifyListeners();
    } catch (e) {
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
      notifyListeners();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }
}
