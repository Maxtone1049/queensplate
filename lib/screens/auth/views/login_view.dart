import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queen_plate_delivery/Common/Gap.dart';
import 'package:queen_plate_delivery/Common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/Common/TextView/TextView.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/common/AppUtils/Form_Validator.dart';
import 'package:queen_plate_delivery/common/AppUtils/app_ui_components.dart';
import 'package:queen_plate_delivery/common/Body/BodyWidget.dart';
import 'package:queen_plate_delivery/common/Body/Model/BodyConfig.dart';
import 'package:queen_plate_delivery/common/Button/ButtonWidget.dart';
import 'package:queen_plate_delivery/common/Button/Model/ButtonConfig.dart';
import 'package:queen_plate_delivery/common/EditField/EditFieldView.dart';
import 'package:queen_plate_delivery/common/EditField/Model/EditFieldConfig.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/main_core/app.router.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
import 'package:queen_plate_delivery/screens/auth/model/login_user_model.dart';
import 'package:queen_plate_delivery/screens/auth/view_model/auth_view_model.dart';
import 'package:queen_plate_delivery/screens/auth/views/login_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(
  fields: [
    FormTextField(name: 'email'),
    FormTextField(name: 'password'),
  ],
)
class LoginView extends StatelessWidget with $LoginView {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => locator<AuthViewModel>(),
      disposeViewModel: false,
      onViewModelReady: (model) {},
      onDispose: (viewModel) => disposeForm(),
      builder: (_, model, __) {
        return BodyWidget(
          config: BodyConfig(
            showAppBar: false,
            loading: model.isBusy,
            backgroundColor: AppColors.background,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(height: 37),
                  TextView(
                    config: TextViewConfig(
                      text: 'Login',
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Gap(height: 36),
                  EditFormField(
                    config: EditFieldConfig(
                      title: 'Email',
                      label: 'Enter your Email',
                      controller: emailController,
                      focusNode: emailFocusNode,
                      textStyle: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                      validator: FieldValidator.validateEmail(),
                    ),
                  ),
                  Gap(height: 16),
                  EditFormField(
                    config: EditFieldConfig(
                      title: 'Password',
                      label: 'Enter your password',
                      textStyle: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                      validator: FieldValidator.validatePassword(
                        passwordController,
                      ),
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      obscureText: model.passwordVisibility,
                      suffixIconWidget: InkWell(
                        onTap: () => model.togglePasswordVisibility(),
                        child: Icon(
                          !model.passwordVisibility
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.grey500,
                        ),
                      ),
                    ),
                  ),
                  Gap(height: 10),
                  TextView(
                    config: TextViewConfig(
                      text: 'Forgot Password?',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                      onTap: () {
                        PageRouter.pushNamed(Routes.forgetPasswordView);
                      },
                    ),
                  ),
                  Gap(height: 36),
                  ButtonWidget(
                    config: ButtonConfig(
                      text: 'Login',
                      height: 57,
                      radius: 18,
                      fontSize: 16,
                      // loading: model.isLoading ?? false,
                      fontWeight: FontWeight.w700,
                      onPressed: () => {
                        passwordFocusNode.unfocus(),
                        if (passwordController.text.isNotEmpty ||
                            emailController.text.isNotEmpty)
                          {
                            model.loginUser(
                              LoginUserModel(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            ),
                          }
                        else
                          {
                            AppUiComponents.triggerNotification(
                              "Input Email and Password",
                              error: true,
                            ),
                          },
                      },
                      textColor: AppColors.white,
                    ),
                  ),
                  Gap(height: 8),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ImageView(
                  //     imageConfig: ImageConfig(
                  //       imageURL: AppImage.orimage,
                  //       imageType: ImageType.svg,
                  //     ),
                  //   ),
                  // ),
                  // Gap(height: 8),
                  // Container(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: 16.w,
                  //     vertical: 12.h,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: AppColors.white,
                  //     border: Border.all(
                  //       color: AppColors.grey1100.withAlpha(
                  //         (0.18 * 255).toInt(),
                  //       ),
                  //     ),
                  //     borderRadius: BorderRadius.circular(18),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       ImageView(
                  //         imageConfig: ImageConfig(
                  //           imageURL: AppImage.google,
                  //           imageType: ImageType.svg,
                  //         ),
                  //       ),
                  //       Gap(width: 10),
                  //       TextView(
                  //         config: TextViewConfig(
                  //           text: 'Sign Up with Google',
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w500,
                  //           color: AppColors.black,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Gap(height: 90),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Color(0xffC19F32),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                PageRouter.pushNamed(Routes.registerView);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
