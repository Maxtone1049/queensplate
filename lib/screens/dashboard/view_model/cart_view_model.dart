import 'package:queen_plate_delivery/common/AppUtils/app_ui_components.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/main_core/app.logger.dart';
import 'package:queen_plate_delivery/core/main_core/app.router.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
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
import 'package:queen_plate_delivery/screens/dashboard/view_model/profile_view_model.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class CartViewModel extends ProfileViewModel {
  CartViewModel();
  String? _customDeliveryAddress;
  String? get customDeliveryAddress => _customDeliveryAddress;

  void setDeliveryAddress(String address) {
    _customDeliveryAddress = address;
    notifyListeners();
  }

  int quantity = 1;

  Future<void> detailIncrease(String? cartItemId, String? mainFoodId) async {
    final cartDetails = menuDetail?.data?.cartDetails;

    if (cartDetails != null && cartItemId != null && cartItemId.isNotEmpty) {
      // Item already in cart → update backend via "increase"
      await updateFoodCartItem(
        UpdateQuantityModel(type: "increase"),
        cartItemId,
      );
      await fetchMenuDetail(mainFoodId ?? '');
    } else {
      // Item not in cart → just increase local quantity
      quantity++;
      notifyListeners();
    }
  }

  // Decrease quantity
  Future<void> detailDecrease(String? cartItemId, String? mainFoodId) async {
    final cartDetails = menuDetail?.data?.cartDetails;

    if (cartDetails != null && cartItemId != null && cartItemId.isNotEmpty) {
      // Item already in cart → get current quantity from server
      final currentQty = int.tryParse(cartDetails.quantity ?? '0') ?? 0;

      if (currentQty > 1) {
        await updateCartItem(UpdateQuantityModel(type: "decrease"), cartItemId);
      } else if (currentQty == 1) {
        await deleteCartItem(cartItemId);
      }
      await fetchMenuDetail(mainFoodId ?? '');
    } else {
      // Item not in cart → just decrease local quantity (never below 1)
      if (quantity > 1) {
        quantity--;
        notifyListeners();
      }
    }
  }

  String selectedPaymentMethod = "";
  bool? _isLoad;
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
      selectedCategoryName = "All";
    } else {
      final category = menuList?.data?.categories.firstWhere(
        (cat) => cat.id == categoryId,
        orElse: () => throw Exception(),
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

  void addToCart({
    required String foodName,
    required String price,
    required int quantity,
    required String imageUrl,
    required AddCartModel model,
  }) {
    // AppUiComponents.triggerNotification(
    //   "Added $quantity x $foodName to cart",
    //   error: false,
    // );
    sendToCart(model);
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
  Future<void> sendToCart(AddCartModel cartModel) async {
    try {
      _isLoad = true;
      _cartAdd = await runBusyFuture(
        cartRepo.addToCart(cartModel),
        throwException: true,
        busyObject: false,
      );
      _isLoad = false;
      AppUiComponents.triggerNotification(
        _cartAdd!.message.toString(),
        error: false,
      );
      await fetchMenuDetail(cartModel.foodItemId.toString());
      notifyListeners();
    } catch (e) {
      _isLoad = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
      notifyListeners();
    }
  }

  MenuListResModel? _menuList;
  MenuListResModel? get menuList => _menuList;
  Future<void> fetchMenu() async {
    try {
      _isLoad = true;
      _menuList = await runBusyFuture(cartRepo.getMenu(), throwException: true);
      _isLoad = false;
      notifyListeners();
    } catch (e) {
      _isLoad = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
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
      AppUiComponents.triggerNotification(
        "${_updateQuantity?.message}",
        error: false,
      );
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
      AppUiComponents.triggerNotification(
        "${_updateQuantity?.message}",
        error: false,
      );
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
