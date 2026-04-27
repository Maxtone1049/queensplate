import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/AppUtils/app_helpers.dart';
import 'package:queen_plate_delivery/common/Button/ButtonWidget.dart';
import 'package:queen_plate_delivery/common/Button/Model/ButtonConfig.dart';
import 'package:queen_plate_delivery/common/Image/ImageView.dart';
import 'package:queen_plate_delivery/common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/common/TextView/TextView.dart';

class MobileOnlyScreen extends StatelessWidget {
  const MobileOnlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageView(
                  imageConfig: ImageConfig(
                    imageURL: AppImage.logo,
                    imageType: ImageType.asset,
                  ),
                ),
                SizedBox(height: 40.h),
                TextView(
                  config: TextViewConfig(
                    text: "Mobile Access Only",
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16.h),
                TextView(
                  config: TextViewConfig(
                    text:
                        "Queen Plate Delivery is optimized for mobile phones.\n\n"
                        "Please open this link on your mobile phone (Android or iOS) to use the app.",
                    fontSize: 17,
                    lineHeight: 1.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey1000,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40.h),
                // Optional: Add a button to copy the current URL for easy sharing
                ButtonWidget(
                  config: ButtonConfig(
                    text: "Copy Link",
                    height: 60,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    radius: 20.r,
                    onPressed: () {
                      // You can add logic to copy the current URL if needed
                      AppHelpers.copy("https://app.queensplate.store/");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Link copied! Open on your phone."),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
