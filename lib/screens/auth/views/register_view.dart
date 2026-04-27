import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/Common/Gap.dart';
import 'package:queen_plate_delivery/Common/Image/ImageView.dart';
import 'package:queen_plate_delivery/Common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/Common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/Common/TextView/TextView.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
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
import 'package:queen_plate_delivery/screens/auth/model/register_user_model.dart';
import 'package:queen_plate_delivery/screens/auth/view_model/auth_view_model.dart';
import 'package:queen_plate_delivery/screens/auth/views/register_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(
  fields: [
    FormTextField(name: 'email'),
    FormTextField(name: 'fullname'),
    FormTextField(name: 'password'),
    FormTextField(name: 'confPassword'),
  ],
)
class RegisterView extends StatelessWidget with $RegisterView {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => locator<AuthViewModel>(),
      disposeViewModel: false,
      onDispose: (viewModel) => disposeForm(),
      onViewModelReady: (model) {},
      builder: (_, model, __) {
        return BodyWidget(
          config: BodyConfig(
            showAppBar: true,
            elevation: 0,
            loading: model.isBusy,
            appbarBackgroundColor: AppColors.background,
            showLeadingWidget: true,
            leadingWidget: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: ImageView(
                imageConfig: ImageConfig(
                  imageURL: AppImage.backarrow,
                  imageType: ImageType.svg,
                  height: 20,
                  onTap: () {
                    PageRouter.pop();
                  },
                ),
              ),
            ),
            backgroundColor: AppColors.background,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    config: TextViewConfig(
                      text: 'Sign up',
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Gap(height: 36),
                  EditFormField(
                    config: EditFieldConfig(
                      title: 'Full Name',
                      label: 'John Doe',
                      controller: fullnameController,
                      focusNode: fullnameFocusNode,
                      validator: FieldValidator.validateName(),
                    ),
                  ),
                  Gap(height: 16),
                  EditFormField(
                    config: EditFieldConfig(
                      title: 'Email',
                      label: 'testmail@mail.com',
                      controller: emailController,
                      focusNode: emailFocusNode,
                      validator: FieldValidator.validateEmail(),
                    ),
                  ),
                  Gap(height: 16),
                  EditFormField(
                    config: EditFieldConfig(
                      title: 'Password',
                      label: 'Enter your password',
                      validator: FieldValidator.validatePass(),
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
                  Gap(height: 16),
                  EditFormField(
                    config: EditFieldConfig(
                      title: 'Confirm Password',
                      label: 'Enter your password again',
                      validator: FieldValidator.validatePassword(
                        passwordController,
                      ),
                      controller: confPasswordController,
                      focusNode: confPasswordFocusNode,
                      obscureText: model.confirmPasswordVisibility,
                      suffixIconWidget: InkWell(
                        onTap: () => model.toggleConfirmPasswordVisibility(),
                        child: Icon(
                          !model.confirmPasswordVisibility
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.grey500,
                        ),
                      ),
                    ),
                  ),
                  Gap(height: 36),
                  ButtonWidget(
                    config: ButtonConfig(
                      text: 'Sign up',
                      height: 50,
                      radius: 18,
                      fontSize: 16,
                      // loading: model.isLoading ?? false,
                      fontWeight: FontWeight.w700,
                      onPressed: () {
                        if (fullnameController.text.isNotEmpty ||
                            emailController.text.isNotEmpty ||
                            passwordController.text.isNotEmpty ||
                            confPasswordController.text.isNotEmpty) {
                          model.signUpUser(
                            RegisterUserModel(
                              name: fullnameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              passwordConfirmation: confPasswordController.text,
                            ),
                          );
                        } else {
                          AppUiComponents.triggerNotification(
                            "Fill in the Details",
                            error: true,
                          );
                        }
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
                        text: 'Already have an account? ',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Color(0xffC19F32),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                PageRouter.pushNamed(Routes.loginView);
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
