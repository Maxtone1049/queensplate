import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/Common/Image/ImageView.dart';
import 'package:queen_plate_delivery/Common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/Body/BodyWidget.dart';
import 'package:queen_plate_delivery/common/Body/Model/BodyConfig.dart';
import 'package:queen_plate_delivery/common/Gap.dart';
import 'package:queen_plate_delivery/common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/common/TextView/TextView.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/main_core/app.router.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/profile_view_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/profile/alert_dialog/confirm_logout_dialog.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => locator<ProfileViewModel>(),
      disposeViewModel: false,
      builder: (_, model, _) {
        return BodyWidget(
          config: BodyConfig(
            backgroundColor: AppColors.background,
            childPadding: EdgeInsets.zero,
            child: Column(
              children: [
                // Header with Background Image
                Container(
                  height: 180.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/faintImage.png",
                      ), // You can replace with your food image
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Title
                      Positioned(
                        top: 45.h,
                        left: 0,
                        right: 0,
                        child: TextView(
                          config: TextViewConfig(
                            text: "Profile",
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.yellow50,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Profile Card
                Transform.translate(
                  offset: Offset(0, -40.h),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 13.w),
                    padding: EdgeInsets.symmetric(vertical: 21, horizontal: 11),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((0.05 * 225).toInt()),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Profile Picture
                        CircleAvatar(
                          radius: 35.r,
                          backgroundImage: const NetworkImage(
                            "https://picsum.photos/id/64/200/200",
                          ), // Replace with real image
                        ),
                        Gap(width: 8),

                        // User Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                config: TextViewConfig(
                                  text: model.name,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Gap(height: 4.h),
                              TextView(
                                config: TextViewConfig(
                                  text: model.email,
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Edit Button
                        GestureDetector(
                          onTap: () => {},
                          child: ImageView(
                            imageConfig: ImageConfig(
                              imageURL: AppImage.edit,
                              imageType: ImageType.svg,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Gap(height: 16),

                // Menu Items
                Expanded(
                  child: Column(
                    children: [
                      buildMenuItem(
                        icon: AppImage.orderhistory,
                        title: "Order History",
                        onTap: () =>
                            PageRouter.pushNamed(Routes.orderHistoryView),
                      ),
                      buildMenuItem(
                        icon: AppImage.deliverydetails,
                        title: "Delivery Details",
                        onTap: () =>
                            PageRouter.pushNamed(Routes.deliveryDetailsView),
                      ),
                      buildMenuItem(
                        icon: AppImage.contactus,
                        title: "Contact Us",
                        onTap: () => PageRouter.pushNamed(Routes.contactUsView),
                      ),
                      buildMenuItem(
                        icon: AppImage.feedback,
                        title: "Feedback",
                        onTap: () => PageRouter.pushNamed(Routes.feedbackView),
                      ),
                      buildMenuItem(
                        icon: AppImage.logout,
                        title: "Log Out",
                        onTap: () => {
                          showDialog(
                            context: context,
                            builder: (context) => ConfirmLogoutDialog(),
                          ),
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMenuItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 4.h),
          leading: Container(
            padding: EdgeInsets.all(10.w),

            child: ImageView(
              imageConfig: ImageConfig(
                imageURL: icon,
                imageType: ImageType.svg,
                height: 40.h,
              ),
            ),
          ),
          title: TextView(
            config: TextViewConfig(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: onTap,
        ),
        const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
      ],
    );
  }
}
