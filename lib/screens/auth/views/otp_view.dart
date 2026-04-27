import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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
import 'package:queen_plate_delivery/common/Image/ImageView.dart';
import 'package:queen_plate_delivery/common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
import 'package:queen_plate_delivery/screens/auth/model/verify_otp_model.dart';
import 'package:queen_plate_delivery/screens/auth/view_model/auth_view_model.dart';
import 'package:queen_plate_delivery/screens/auth/views/otp_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [FormTextField(name: 'otp')])
class OtpView extends StatelessWidget with $OtpView {
  const OtpView({super.key, required this.email});
  final String email;
  // var otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => locator<AuthViewModel>(),
      disposeViewModel: false,
      onViewModelReady: (model) {},
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
                      text: 'Enter 4 digit code',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(height: 8),
                  TextView(
                    config: TextViewConfig(
                      text:
                          'Enter 4 digit code that your receive on your email ($email)',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Gap(height: 32),
                  PinCodeTextField(
                    keyboardType: TextInputType.number,
                    mainAxisAlignment: MainAxisAlignment.center,
                    length: 4,
                    controller: otpController,
                    validator: FieldValidator.validateOTP(),
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      fieldOuterPadding: EdgeInsets.only(left: 4.w, right: 3.w),
                      borderRadius: BorderRadius.circular(8.r),
                      borderWidth: 0,
                      fieldWidth: 55.w,
                      fieldHeight: 48.h,
                      activeFillColor: AppColors.grey50,
                      inactiveColor: AppColors.grey200,
                      selectedColor: AppColors.grey50,
                      activeColor: AppColors.grey200,
                      inactiveFillColor: AppColors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    appContext: context,
                    onChanged: (String value) {},
                  ),
                  Gap(height: 13),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Not received a code? ',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: 'Resend',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Color(0xffC19F32),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ),

                  Gap(height: 90),
                  ButtonWidget(
                    config: ButtonConfig(
                      text: 'Continue',
                      height: 57,
                      radius: 18,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      loading: model.isLoading ?? false,
                      onPressed: () {
                        if (otpController.text.isNotEmpty) {
                          model.confirmOtp(
                            VerifyOtpModel(
                              email: email,
                              otp: otpController.text,
                            ),
                          );
                        } else {
                          AppUiComponents.triggerNotification(
                            "Input Complete Otp",
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
