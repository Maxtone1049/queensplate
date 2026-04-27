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
import 'package:queen_plate_delivery/screens/dashboard/models/order_history_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/profile_view_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/sub_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/cart/widgets/checkout_widget.dart';
import 'package:stacked/stacked.dart';

class OrderTrackingView extends StatelessWidget {
  final String orderId;
  final OrderData orderInfo;

  const OrderTrackingView({
    super.key,
    required this.orderId,
    required this.orderInfo,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => locator<ProfileViewModel>(),
      onViewModelReady: (model) =>
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            model.startOrderTracking(orderInfo.id.toString());
            model.trackOrderStatus(orderInfo.id.toString());
          }),
      onDispose: (model) => model.stopOrderTracking(),
      disposeViewModel: false,
      builder: (_, model, _) {
        return BodyWidget(
          config: BodyConfig(
            backgroundColor: const Color(0xFFF8F5F0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          text: "Order Tracking",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),

                // Order Info
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.yellow100,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextView(
                        config: TextViewConfig(
                          text: "Order $orderId",
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          ImageView(
                            imageConfig: ImageConfig(
                              imageURL: AppImage.time,
                              imageType: ImageType.svg,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Gap(height: 20.h),
                TextView(
                  config: TextViewConfig(
                    text:
                        "Note: ${model.orderStatusModel?.data?.checkoutNote ?? "N/A"}",
                    fontSize: 14.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(height: 20.h),

                model.orderStatusModel?.data?.cancellationReason != 'null'
                    ? TextView(
                        config: TextViewConfig(
                          text:
                              "Reason: ${model.orderStatusModel?.data?.cancellationReason ?? "N/A"}",
                          fontSize: 14.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : SizedBox.shrink(),
                // Rider Location / Map Section
                Gap(height: 24.h),

                // Dynamic Tracking Steps
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...model.trackingSteps.map(
                          (step) => _buildTrackingStep(step, model),
                        ),
                        Gap(height: 23),
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                config: TextViewConfig(
                                  text: "Order Summary",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                                color: Color(0xFFF0F0F0),
                              ),
                              Gap(height: 29),
                              ...orderInfo.items.map(
                                (items) => buildOrderItem(
                                  items.foodItem!.name.toString(),
                                  int.tryParse(items.quantity.toString()) ?? 0,
                                  int.tryParse(
                                    items.price.toString().replaceAll(
                                      ".00",
                                      "",
                                    ),
                                  )!,
                                ),
                              ),
                              Gap(height: 12.h),
                              const Divider(
                                thickness: 1,
                                color: Color(0xFFF0F0F0),
                              ),
                              Gap(height: 12.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextView(
                                    config: TextViewConfig(
                                      text: "Sub Total",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextView(
                                    config: TextViewConfig(
                                      text:
                                          "₦${model.orderStatusModel?.data?.subtotal}",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(height: 12.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextView(
                                    config: TextViewConfig(
                                      text: "Delivery Fee",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextView(
                                    config: TextViewConfig(
                                      text:
                                          "₦${model.orderStatusModel?.data?.deliveryFee}",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(height: 12.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextView(
                                    config: TextViewConfig(
                                      text: "Tax",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextView(
                                    config: TextViewConfig(
                                      text:
                                          "₦${model.orderStatusModel?.data?.tax}",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(height: 12.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextView(
                                    config: TextViewConfig(
                                      text: "Total",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextView(
                                    config: TextViewConfig(
                                      text:
                                          "₦${model.orderStatusModel?.data?.totalAmount}",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary,
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
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrackingStep(TrackingStep step, ProfileViewModel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.yellow100,
              ),
              child: Icon(
                step.icon,
                color: step.isCompleted ? AppColors.primary : AppColors.white,
                size: 22.sp,
              ),
            ),
            if (!step.isLast)
              Container(
                width: 2.w,
                height: 52.h,
                color: step.isCompleted ? AppColors.primary : AppColors.white,
              ),
          ],
        ),
        Gap(width: 16.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  config: TextViewConfig(
                    text: step.title,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                Gap(height: 4.h),
                TextView(
                  config: TextViewConfig(
                    text: step.subtitle,
                    fontSize: 11,
                    color: AppColors.gent,
                  ),
                ),
                Gap(height: step.isLast ? 0 : 40.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
