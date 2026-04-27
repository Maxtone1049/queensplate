import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/Common/Gap.dart';
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
import 'package:queen_plate_delivery/common/Image/ImageView.dart';
import 'package:queen_plate_delivery/common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
import 'package:queen_plate_delivery/screens/auth/model/forget_password_model.dart';
import 'package:queen_plate_delivery/screens/auth/view_model/auth_view_model.dart';
import 'package:queen_plate_delivery/screens/auth/views/forget_password_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [FormTextField(name: 'email')])
class ForgetPasswordView extends StatelessWidget with $ForgetPasswordView {
  const ForgetPasswordView({super.key});

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
            showAppBar: true,
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
            elevation: 0,
            backgroundColor: AppColors.background,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    config: TextViewConfig(
                      text: 'Forget Password',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(height: 8),
                  TextView(
                    config: TextViewConfig(
                      text: 'Enter your email for the verification process.',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Gap(height: 36),
                  EditFormField(
                    config: EditFieldConfig(
                      title: 'Email Address',
                      label: "johndoe@mail.com",
                      controller: emailController,
                      focusNode: emailFocusNode,
                      validator: FieldValidator.validateEmail(),
                    ),
                  ),
                  Gap(height: 36),
                  ButtonWidget(
                    config: ButtonConfig(
                      text: 'Send Code',
                      height: 50,
                      radius: 18,
                      fontSize: 16,
                      loading: model.isLoading??false,
                      fontWeight: FontWeight.w700,
                      onPressed: () {
                        if (emailController.text.isNotEmpty) {
                          model.forgotPass(
                            ForgetPasswordModel(email: emailController.text),
                          );
                        } else {
                          AppUiComponents.triggerNotification(
                            'Please enter your email address',
                            error: true,
                          );
                        }
                      },
                      textColor: AppColors.white,
                    ),
                  ),
                  Gap(height: 90),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
