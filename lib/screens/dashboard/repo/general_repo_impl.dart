import 'package:queen_plate_delivery/common/appmanager/shared_preferences.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/add_cart_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/add_cart_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/checkout_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/checkout_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/get_all_user_review_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/list_cart_item_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/menu_detail_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/menu_list_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/order_history_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/order_status_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/send_review_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/send_review_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/update_quantity_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/update_quantity_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/update_user_profile.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/update_user_profile_res.dart';
import 'package:queen_plate_delivery/screens/dashboard/order_api/order_api.dart';
import 'package:queen_plate_delivery/screens/dashboard/repo/general_repo.dart';

class GeneralRepoImpl implements GeneralRepo {
  final session = locator<SharedPreferencesService>();
  final orderApi = locator<OrderApi>();
  @override
  Future<AddCartResModel> addToCart(AddCartModel model) async =>
      await orderApi.addToCart(model);

  @override
  Future<MenuListResModel> getMenu() async => await orderApi.getMenu();

  @override
  Future<MenuDetailResModel> getMenuDetail(String id) async =>
      await orderApi.getMenuDetail(id);

  @override
  Future<ListCartResModel> listCartItem() async =>
      await orderApi.listCartItem();

  @override
  Future<AddCartResModel> removeCartItem(String foodId) async =>
      await orderApi.removeCartItem(foodId);

  @override
  Future<CheckoutResModel> checkoutUser(CheckoutModel checkout) async =>
      await orderApi.checkout(checkout);

  @override
  Future<OrderHistoryResModel> getOrderHistory() async =>
      await orderApi.getOrderHistory();

  @override
  Future<UpdateQuantityResModel> updateCartitem(
    UpdateQuantityModel model,
    String itemId,
  ) async => await orderApi.changeQuantity(model, itemId);

  @override
  Future<UpdateUserProfileResModel> updateUserProfile(
    UpdateUserProfile model,
  ) async => await orderApi.updateUser(model);

  @override
  Future<OrderStatusResModel> getOrderStatus(String orderId) async =>
      await orderApi.getOrderStatus(orderId);

  @override
  Future<GetAllUserReviewModel> getUserReviews() async =>
      await orderApi.getUserReview();

  @override
  Future<SendReviewResModel> sendFeedBack(SendReviewModel model) async =>
      await orderApi.sendUserFeedback(model);
}
