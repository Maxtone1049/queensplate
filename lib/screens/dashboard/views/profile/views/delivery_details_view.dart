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
import 'package:queen_plate_delivery/core/main_core/app.router.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/profile_view_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/profile/widgets/profile_widget.dart';
import 'package:stacked/stacked.dart';

class DeliveryDetailsView extends StatelessWidget {
  const DeliveryDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => locator<ProfileViewModel>(),
      onViewModelReady: (model) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await model.getCurrentDeliveryAddress();
        });
      },
      disposeViewModel: false,
      builder: (_, model, _) {
        return BodyWidget(
          config: BodyConfig(
            backgroundColor: AppColors.background,
            childPadding: EdgeInsets.zero,
            child: Column(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  child: Row(
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
                          text: "Delivery Details",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),

                // Map Section
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  height: 200.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.network(
                      "https://picsum.photos/id/1015/800/400", // Replace with real map image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Gap(height: 24.h),

                // Residential Details Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextView(
                        config: TextViewConfig(
                          text: "Residential Details",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextView(
                        config: TextViewConfig(
                          text: "Edit",
                          fontSize: 14,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          onTap: () => PageRouter.pushNamed(
                            Routes.editDeliveryDetailView,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(height: 16.h),

                // Address Card
                buildDetailCard(
                  icon: AppImage.homefilled,
                  title: model.addressMain != ''
                      ? "${model.addressMain}, ${model.addressState}, ${model.addressCountry}"
                      : model.deliveryAddress,
                  subtitle: "Residential Address",
                  onCopy: () => model.copyToClipboard(
                    context,
                    model.addressMain != ''
                        ? "${model.addressMain}, ${model.addressState}, ${model.addressCountry}"
                        : model.deliveryAddress,
                  ),
                ),

                Gap(height: 16),

                // Phone Card
                buildDetailCard(
                  icon: AppImage.callus,
                  title: model.phoneNumber,
                  subtitle: "Mobile Number",
                  onCopy: () => model.copyToClipboard(
                    context,
                    model.phoneNumber != "null" ? model.phoneNumber : 'N/A',
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
