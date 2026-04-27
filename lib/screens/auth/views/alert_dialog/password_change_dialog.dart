import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/Button/ButtonWidget.dart';
import 'package:queen_plate_delivery/common/Button/Model/ButtonConfig.dart';
import 'package:queen_plate_delivery/common/Gap.dart';
import 'package:queen_plate_delivery/common/Image/ImageView.dart';
import 'package:queen_plate_delivery/common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/common/TextView/TextView.dart';
import 'package:queen_plate_delivery/core/main_core/app.router.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';

class PasswordChangeDialog extends StatelessWidget {
  const PasswordChangeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.close, size: 20.sp, color: Colors.black),
              ),
            ),
            SizedBox(height: 24),
            ImageView(
              imageConfig: ImageConfig(
                imageURL: AppImage.check,
                imageType: ImageType.svg,
              ),
            ),
            // Image.asset("assets/png/celebration.png"),
            Gap(height: 16),
            TextView(
              config: TextViewConfig(
                text: "Password Changed",
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gap(height: 8),
            TextView(
              config: TextViewConfig(
                text: "You can now use your new password to login.",
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap(height: 20),
            ButtonWidget(
              config: ButtonConfig(
                text: "Login",
                onPressed: () {
                  PageRouter.pop();
                  PageRouter.pushReplacement(Routes.onboardingView);
                },
                height: 57,
                textColor: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                radius: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
