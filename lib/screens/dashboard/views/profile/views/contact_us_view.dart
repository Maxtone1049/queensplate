import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/AppUtils/app_helpers.dart';
import 'package:queen_plate_delivery/common/Body/BodyWidget.dart';
import 'package:queen_plate_delivery/common/Body/Model/BodyConfig.dart';
import 'package:queen_plate_delivery/common/Gap.dart';
import 'package:queen_plate_delivery/common/Image/ImageView.dart';
import 'package:queen_plate_delivery/common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/common/TextView/TextView.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/profile_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => locator<ProfileViewModel>(),
      disposeViewModel: false,
      onViewModelReady: (model) {},
      builder: (_, model, _) {
        return BodyWidget(
          config: BodyConfig(
            childPadding: EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: AppColors.background,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(height: 20),
                  Row(
                    children: [
                      ImageView(
                        imageConfig: ImageConfig(
                          imageURL: AppImage.circlebackarrow,
                          imageType: ImageType.svg,
                          onTap: () => PageRouter.pop(),
                        ),
                      ),
                      const Spacer(),
                      TextView(
                        config: TextViewConfig(
                          text: "Contact Us",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  Gap(height: 16),
                  TextView(
                    config: TextViewConfig(
                      text:
                          "Have a question or need help? Our team is here for you. Reach out and we’ll be happy to assist.",
                      textAlign: TextAlign.center,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(height: 16),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ImageView(
                              imageConfig: ImageConfig(
                                imageURL: AppImage.callus,
                                imageType: ImageType.svg,
                              ),
                            ),
                            Gap(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    config: TextViewConfig(
                                      text: "+234 810 242 0761",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Gap(height: 4),
                                  TextView(
                                    config: TextViewConfig(
                                      text: "Contact Number",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(height: 16),
                        Row(
                          children: [
                            ImageView(
                              imageConfig: ImageConfig(
                                imageURL: AppImage.mail,
                                imageType: ImageType.svg,
                              ),
                            ),
                            Gap(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    config: TextViewConfig(
                                      text: "queensplate@outlook.com",
                                      onTap: () {
                                        var email =
                                            "mailto:queensplate@outlook.com";
                                        AppHelpers.launchURL(
                                          Uri.parse(email),
                                          mode: LaunchMode.platformDefault,
                                        );
                                      },
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Gap(height: 4),
                                  TextView(
                                    config: TextViewConfig(
                                      text: "Email Address",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(height: 26),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          config: TextViewConfig(
                            text: "Social Media",
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Gap(height: 16),
                        Row(
                          children: [
                            ImageView(
                              imageConfig: ImageConfig(
                                imageURL: AppImage.facebook,
                                imageType: ImageType.asset,
                              ),
                            ),
                            Gap(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    config: TextViewConfig(
                                      text: "Facebook",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Gap(height: 4),
                                  TextView(
                                    config: TextViewConfig(
                                      text: "Queen Plate Food Express",
                                      onTap: () {
                                        var email =
                                            "https://www.facebook.com/share/18JKvcLQj8/";
                                        AppHelpers.launchURL(
                                          Uri.parse(email),
                                          mode: LaunchMode.platformDefault,
                                        );
                                      },
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(height: 18),
                        Row(
                          children: [
                            ImageView(
                              imageConfig: ImageConfig(
                                imageURL: AppImage.instagram,
                                imageType: ImageType.asset,
                              ),
                            ),
                            Gap(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    config: TextViewConfig(
                                      text: "Instagram",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Gap(height: 4),
                                  TextView(
                                    config: TextViewConfig(
                                      text: "Queen Plate Food Express",
                                      onTap: () {
                                        var email =
                                            "https://www.instagram.com/queensplate01?igsh=YXNqMmM5dzdtbm9y";
                                        AppHelpers.launchURL(
                                          Uri.parse(email),
                                          mode: LaunchMode.platformDefault,
                                        );
                                      },
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(height: 18),
                        Row(
                          children: [
                            ImageView(
                              imageConfig: ImageConfig(
                                imageURL: AppImage.instagram,
                                imageType: ImageType.asset,
                              ),
                            ),
                            Gap(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    config: TextViewConfig(
                                      text: "Tiktok",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Gap(height: 4),
                                  TextView(
                                    config: TextViewConfig(
                                      text: "Queen Plate Food Express",
                                      onTap: () {
                                        var email =
                                            "https://vm.tiktok.com/ZS9LCAaCV28e1-d6lpL/";
                                        AppHelpers.launchURL(
                                          Uri.parse(email),
                                          mode: LaunchMode.platformDefault,
                                        );
                                      },
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
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
