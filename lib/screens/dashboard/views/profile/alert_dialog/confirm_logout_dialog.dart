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
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/profile_view_model.dart';
import 'package:stacked/stacked.dart';

class ConfirmLogoutDialog extends StatelessWidget {
  const ConfirmLogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => locator<ProfileViewModel>(),
      disposeViewModel: false,
      builder: (_, model, _) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
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
                    imageURL: AppImage.confirmlogout,
                    imageType: ImageType.svg,
                  ),
                ),
                // Image.asset("assets/png/celebration.png"),
                Gap(height: 16),
                TextView(
                  config: TextViewConfig(
                    text: "Are you sure you want to log out?",
                    textAlign: TextAlign.center,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gap(height: 8),
                TextView(
                  config: TextViewConfig(
                    text: "You can keep ordering.",
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Gap(height: 20),
                ButtonWidget(
                  config: ButtonConfig(
                    text: "Log Out",
                    onPressed: () {
                      PageRouter.pop();
                      model.logout();
                    },
                    height: 57,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    radius: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
