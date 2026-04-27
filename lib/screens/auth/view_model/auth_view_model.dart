import 'package:flutter/material.dart';
import 'package:queen_plate_delivery/common/AppUtils/app_ui_components.dart';
import 'package:queen_plate_delivery/common/appmanager/shared_preferences.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/main_core/app.logger.dart';
import 'package:queen_plate_delivery/core/main_core/app.router.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
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
import 'package:queen_plate_delivery/screens/auth/repository/auth_repo_impl.dart';
import 'package:queen_plate_delivery/screens/auth/views/alert_dialog/password_change_dialog.dart';
import 'package:stacked/stacked.dart';

class AuthViewModel extends BaseViewModel {
  AuthViewModel();

  bool _passwordVisibility = true;
  bool get passwordVisibility => _passwordVisibility;

  bool _confirmPasswordVisibility = true;
  bool get confirmPasswordVisibility => _confirmPasswordVisibility;

  final registerKey = GlobalKey<FormState>();
  final loginKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    _passwordVisibility = !_passwordVisibility;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _confirmPasswordVisibility = !_confirmPasswordVisibility;
    notifyListeners();
  }

  final logger = getLogger("AuthViewModel");
  final authRepo = locator<AuthRepoImpl>();
  final session = locator<SharedPreferencesService>();

  bool? _isLoading;
  bool? get isLoading => _isLoading;
  RegisterUserResModel? _userResModel;
  RegisterUserResModel? get userResModel => _userResModel;
  Future<void> signUpUser(RegisterUserModel register) async {
    try {
      _isLoading = true;
      _userResModel = await runBusyFuture(
        authRepo.registerUser(register),
        throwException: true,
      );
      _isLoading = false;
      if (_userResModel?.success != false) {
        PageRouter.pushNamed(Routes.loginView);
        AppUiComponents.triggerNotification(
          "Welcome to Queens Plate",
          error: false,
        );
      }
    } catch (e) {
      _isLoading = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(
        "Registration Failed, Kindly Try again",
        error: false,
      );
    }
  }

  LoginUserResModel? _loginResModel;
  LoginUserResModel? get loginResModel => _loginResModel;
  Future<void> loginUser(LoginUserModel login) async {
    try {
      _isLoading = true;
      _loginResModel = await runBusyFuture(
        authRepo.loginUser(login),
        throwException: true,
      );
      _isLoading = false;
      session.isLoggedIn = true;
      session.authToken = _loginResModel!.data!.accessToken.toString();
      if (_loginResModel?.success != false) {
        await fetchUser();
      }
    } catch (e) {
      _isLoading = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: false);
    }
  }

  GetUserResModel? _getUser;
  GetUserResModel? get getUser => _getUser;
  Future<void> fetchUser() async {
    try {
      _isLoading = true;
      _getUser = await runBusyFuture(authRepo.getUser(), throwException: true);
      _isLoading = false;
      session.usersData = _getUser!.data!.toJson();
      if (_getUser?.success != false) {
        PageRouter.pushReplacement(Routes.dashboardView);
        AppUiComponents.triggerNotification("Login Successful", error: false);
      }
    } catch (e) {
      _isLoading = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
    }
  }

  ForgetPassResModel? _forgetPass;
  ForgetPassResModel? get forgetPass => _forgetPass;
  Future<void> forgotPass(ForgetPasswordModel model) async {
    try {
      _isLoading = true;
      _forgetPass = await runBusyFuture(
        authRepo.forgetPass(model),
        throwException: true,
      );
      _isLoading = false;
      if (_forgetPass?.success != false) {
        PageRouter.pushNamed(
          Routes.otpView,
          args: OtpViewArguments(email: model.email.toString()),
        );
      }
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
      notifyListeners();
    }
  }

  //  Verify OTP
  VerifyOtpResModel? _verifyRes;
  VerifyOtpResModel? get verifyRes => _verifyRes;
  Future<void> confirmOtp(VerifyOtpModel model) async {
    try {
      _isLoading = true;
      _verifyRes = await runBusyFuture(
        authRepo.verifyOtp(model),
        throwException: true,
      );
      _isLoading = false;
      if (_verifyRes?.success != false) {
        PageRouter.pushNamed(
          Routes.changePasswordView,
          args: ChangePasswordViewArguments(
            email: model.email.toString(),
            otp: model.otp.toString(),
          ),
        );
      }
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
      notifyListeners();
    }
  }

  // Reset Password
  ResetPasswordResModel? _resetPass;
  ResetPasswordResModel? get resetPass => _resetPass;
  Future<void> resetPassword(
    ResetPasswordModel model,
    BuildContext context,
  ) async {
    try {
      _isLoading = true;
      _resetPass = await runBusyFuture(
        authRepo.resetPass(model),
        throwException: true,
      );
      _isLoading = false;
      if (_resetPass?.success != false) {
        showDialog(
          context: context,
          builder: (context) => PasswordChangeDialog(),
        );
      }
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      logger.d(e.toString());
      AppUiComponents.triggerNotification(e.toString(), error: true);
      notifyListeners();
    }
  }
}
