import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
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

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          text: "Notification",
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
                      text: "Today",
                      textAlign: TextAlign.center,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(height: 10),
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
                                imageURL: AppImage.notify,
                                imageType: ImageType.svg,
                                height: 41.h,
                              ),
                            ),
                            Gap(width: 13),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    config: TextViewConfig(
                                      text: "Weekly New Recipes!",
                                      fontSize: 14,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Gap(height: 2),
                                  TextView(
                                    config: TextViewConfig(
                                      text:
                                          "Discover our new recipes of the week!",
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
