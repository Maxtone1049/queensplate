import 'package:queen_plate_delivery/common/appmanager/shared_preferences.dart';
import 'package:queen_plate_delivery/core/Network/Network_Service.dart';
import 'package:queen_plate_delivery/core/Network/UrlPath.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/screens/auth/model/forget_password_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/forget_password_res_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/get_user_res_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/login_user_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/login_user_res_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/register_user_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/register_user_res_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/reset_password_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/reset_password_res_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/verify_otp_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/verify_otp_res_model.dart';

class AuthApi extends NetworkService {
  @override
  // ignore: overridden_fields
  final session = locator<SharedPreferencesService>();

  Future<RegisterUserResModel> register(RegisterUserModel register) async {
    try {
      session.isFound401erorr = false;
      final res = await call(
        path: UrlConfig.register_user,
        method: RequestMethod.post,
        data: register.toJson(),
      );
      return RegisterUserResModel.fromJson(res.data);
    } catch (_) {
      rethrow;
    }
  }

  Future<LoginUserResModel> login(LoginUserModel login) async {
    try {
      session.isFound401erorr = false;
      final res = await call(
        path: UrlConfig.login,
        method: RequestMethod.post,
        data: login.toJson(),
      );
      return LoginUserResModel.fromJson(res.data);
    } catch (_) {
      rethrow;
    }
  }

  Future<ForgetPassResModel> forgetPassword(ForgetPasswordModel model) async {
    try {
      session.isFound401erorr = false;
      final res = await call(
        path: UrlConfig.forget,
        method: RequestMethod.post,
        data: model.toJson(),
      );
      return ForgetPassResModel.fromJson(res.data);
    } catch (_) {
      rethrow;
    }
  }

  Future<ResetPasswordResModel> resetPassword(ResetPasswordModel model) async {
    try {
      session.isFound401erorr = false;
      final res = await call(
        path: UrlConfig.reset,
        method: RequestMethod.post,
        data: model.toJson(),
      );
      return ResetPasswordResModel.fromJson(res.data);
    } catch (_) {
      rethrow;
    }
  }

  Future<VerifyOtpResModel> verifyOtp(VerifyOtpModel model) async {
    try {
      session.isFound401erorr = false;
      final res = await call(
        path: UrlConfig.veriyOtp,
        method: RequestMethod.post,
        data: model.toJson(),
      );
      return VerifyOtpResModel.fromJson(res.data);
    } catch (_) {
      rethrow;
    }
  }

  Future<GetUserResModel> getUser() async {
    try {
      session.isFound401erorr = false;
      final res = await call(
        path: UrlConfig.getUser,
        method: RequestMethod.get,
      );
      return GetUserResModel.fromJson(res.data);
    } catch (_) {
      rethrow;
    }
  }
}
