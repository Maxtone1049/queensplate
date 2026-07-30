import 'package:queen_plate_delivery/common/appmanager/shared_preferences.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/screens/auth/auth_api/auth_api.dart';
import 'package:queen_plate_delivery/screens/auth/model/email_otp_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/email_verify_res_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/forget_password_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/forget_password_res_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/get_user_res_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/login_user_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/login_user_res_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/register_user_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/register_user_res_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/resend_verification_res_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/reset_password_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/reset_password_res_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/verify_otp_model.dart';
import 'package:queen_plate_delivery/screens/auth/model/verify_otp_res_model.dart';
import 'package:queen_plate_delivery/screens/auth/repository/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final authApi = locator<AuthApi>();
  final session = locator<SharedPreferencesService>();
  @override
  Future<GetUserResModel> getUser() async => await authApi.getUser();

  @override
  Future<LoginUserResModel> loginUser(LoginUserModel register) async {
    final res = await authApi.login(register);
    if (res.data!.accessToken!.isNotEmpty) {
      session.authToken = res.data!.accessToken.toString();
    }
    return res;
  }

  @override
  Future<RegisterUserResModel> registerUser(RegisterUserModel register) async =>
      await authApi.register(register);

  @override
  Future<ForgetPassResModel> forgetPass(ForgetPasswordModel model) async =>
      await authApi.forgetPassword(model);

  @override
  Future<ResetPasswordResModel> resetPass(ResetPasswordModel model) async =>
      await authApi.resetPassword(model);

  @override
  Future<VerifyOtpResModel> verifyOtp(VerifyOtpModel model) async =>
      await authApi.verifyOtp(model);

  @override
  Future<EmailVerifyResModel> emailverifyOtp(VerifyOtpModel model) async =>
      await authApi.emailverify(model);

  @override
  Future<ResendVerificationResModel> resendOTP(EmailOtpModel model) async =>
      await authApi.resendOtp(model);
}
