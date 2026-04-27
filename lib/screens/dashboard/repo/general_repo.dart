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

abstract class GeneralRepo {
  Future<MenuListResModel> getMenu();
  Future<MenuDetailResModel> getMenuDetail(String id);
  Future<AddCartResModel> addToCart(AddCartModel model);
  Future<ListCartResModel> listCartItem();
  Future<AddCartResModel> removeCartItem(String foodId);
  Future<CheckoutResModel> checkoutUser(CheckoutModel checkout);
  Future<OrderHistoryResModel> getOrderHistory();
  Future<UpdateQuantityResModel> updateCartitem(
    UpdateQuantityModel model,
    String itemId,
  );
  Future<UpdateUserProfileResModel> updateUserProfile(UpdateUserProfile model);
  Future<OrderStatusResModel> getOrderStatus(String orderId);
  Future<SendReviewResModel> sendFeedBack(SendReviewModel model);
  Future<GetAllUserReviewModel> getUserReviews();
}
