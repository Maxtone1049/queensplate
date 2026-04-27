import 'package:queen_plate_delivery/common/appmanager/shared_preferences.dart';
import 'package:queen_plate_delivery/core/Network/Network_Service.dart';
import 'package:queen_plate_delivery/core/Network/UrlPath.dart';
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

class OrderApi extends NetworkService {
  @override
  // ignore: overridden_fields
  final session = locator<SharedPreferencesService>();

  Future<MenuListResModel> getMenu() async {
    try {
      session.isFound401erorr = false;
      final res = await call(path: UrlConfig.menu, method: RequestMethod.get);
      return MenuListResModel.fromJson(res.data);
    } catch (_) {
      session.isFound401erorr = true;
      rethrow;
    }
  }

  Future<MenuDetailResModel> getMenuDetail(String id) async {
    try {
      session.isFound401erorr = false;
      final res = await call(
        path: "${UrlConfig.menu}/$id",
        method: RequestMethod.get,
      );
      return MenuDetailResModel.fromJson(res.data);
    } catch (_) {
      session.isFound401erorr = true;
      rethrow;
    }
  }

  Future<AddCartResModel> addToCart(AddCartModel model) async {
    try {
      session.isFound401erorr = false;
      final res = await call(
        path: UrlConfig.addtoCart,
        method: RequestMethod.post,
        data: model.toJson(),
      );
      return AddCartResModel.fromJson(res.data);
    } catch (_) {
      session.isFound401erorr = true;
      rethrow;
    }
  }

  Future<ListCartResModel> listCartItem() async {
    try {
      session.isFound401erorr = false;
      final res = await call(path: UrlConfig.cart, method: RequestMethod.get);
      return ListCartResModel.fromJson(res.data);
    } catch (_) {
      session.isFound401erorr = true;
      rethrow;
    }
  }

  Future<AddCartResModel> removeCartItem(String foodID) async {
    try {
      session.isFound401erorr = false;
      final res = await call(
        path: "${UrlConfig.cart}/$foodID",
        method: RequestMethod.delete,
      );
      return AddCartResModel.fromJson(res.data);
    } catch (_) {
      session.isFound401erorr = true;
      rethrow;
    }
  }

  Future<CheckoutResModel> checkout(CheckoutModel checkout) async {
    try {
      session.isFound401erorr = false;
      final res = await call(
        path: UrlConfig.checkout,
        method: RequestMethod.post,
        data: checkout.toJson(),
      );
      return CheckoutResModel.fromJson(res.data);
    } catch (_) {
      session.isFound401erorr = true;
      rethrow;
    }
  }

  Future<OrderHistoryResModel> getOrderHistory() async {
    try {
      session.isFound401erorr = false;
      final res = await call(
        path: UrlConfig.history,
        method: RequestMethod.get,
      );
      return OrderHistoryResModel.fromJson(res.data);
    } catch (_) {
      session.isFound401erorr = true;
      rethrow;
    }
  }

  //  Get Order Status
  Future<OrderStatusResModel> getOrderStatus(String orderId) async {
    try {
      session.isFound401erorr = false;
      final res = await call(
        path: "${UrlConfig.status}/$orderId",
        method: RequestMethod.get,
      );
      return OrderStatusResModel.fromJson(res.data);
    } catch (_) {
      session.isFound401erorr = true;
      rethrow;
    }
  }

  Future<UpdateQuantityResModel> changeQuantity(
    UpdateQuantityModel model,
    String itemId,
  ) async {
    try {
      session.isFound401erorr = false;
      final res = await call(
        path: "cart/$itemId/update",
        data: model.toJson(),
        method: RequestMethod.patch,
      );
      return UpdateQuantityResModel.fromJson(res.data);
    } catch (_) {
      session.isFound401erorr = true;
      rethrow;
    }
  }

  Future<UpdateUserProfileResModel> updateUser(UpdateUserProfile model) async {
    try {
      session.isFound401erorr = false;
      final res = await call(
        path: UrlConfig.updateUser,
        data: model.toJson(),
        method: RequestMethod.post,
      );
      return UpdateUserProfileResModel.fromJson(res.data);
    } catch (_) {
      session.isFound401erorr = true;
      rethrow;
    }
  }

  Future<SendReviewResModel> sendUserFeedback(SendReviewModel model) async {
    try {
      session.isFound401erorr = false;
      final res = await call(
        method: RequestMethod.post,
        path: UrlConfig.review,
        data: model.toJson(),
      );
      return SendReviewResModel.fromJson(res.data);
    } catch (e) {
      session.isFound401erorr = true;
      rethrow;
    }
  }
 
  Future<GetAllUserReviewModel> getUserReview() async {
    try {
      session.isFound401erorr = false;
      final res = await call(
        method: RequestMethod.get,
        path: UrlConfig.generealreview,
        );
      return GetAllUserReviewModel.fromJson(res.data);
    } catch (e) {
      session.isFound401erorr = true;
      rethrow;
    }
  }
}
