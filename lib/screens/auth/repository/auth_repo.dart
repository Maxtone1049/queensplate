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

abstract class AuthRepo {
  Future<RegisterUserResModel> registerUser(RegisterUserModel register);
  Future<LoginUserResModel> loginUser(LoginUserModel register);
  Future<GetUserResModel> getUser();
  Future<ResetPasswordResModel> resetPass(ResetPasswordModel model);
  Future<VerifyOtpResModel> verifyOtp(VerifyOtpModel model);
  Future<EmailVerifyResModel> emailverifyOtp(VerifyOtpModel model);
  Future<ResendVerificationResModel> resendOTP(EmailOtpModel model);
  Future<ForgetPassResModel> forgetPass(ForgetPasswordModel model);
}
