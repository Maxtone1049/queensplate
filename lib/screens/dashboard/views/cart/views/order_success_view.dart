import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/Common/Gap.dart';
import 'package:queen_plate_delivery/Common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/Common/TextView/TextView.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/Body/BodyWidget.dart';
import 'package:queen_plate_delivery/common/Body/Model/BodyConfig.dart';
import 'package:queen_plate_delivery/common/Button/ButtonWidget.dart';
import 'package:queen_plate_delivery/common/Button/Model/ButtonConfig.dart';
import 'package:queen_plate_delivery/common/Image/ImageView.dart';
import 'package:queen_plate_delivery/common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/main_core/app.router.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/cart_view_model.dart';
import 'package:stacked/stacked.dart';

class OrderSuccessView extends StatelessWidget {
  const OrderSuccessView({
    super.key,
    required this.orderId,
    required this.address,
  });
  final String orderId, address;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.reactive(
      viewModelBuilder: () => locator<CartViewModel>(),
      disposeViewModel: false,
      builder: (_, model, _) {
        return BodyWidget(
          config: BodyConfig(
            backgroundColor: AppColors.background,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Gap(height: 99),
                  ImageView(
                    imageConfig: ImageConfig(
                      imageURL: AppImage.confirmed,
                      imageType: ImageType.svg,
                    ),
                  ),
                  Gap(height: 31),
                  TextView(
                    config: TextViewConfig(
                      text: "Order Confirmed",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                  TextView(
                    config: TextViewConfig(
                      text: "Your order has been placed successfully",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  Gap(height: 31),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextView(
                              config: TextViewConfig(
                                text: "Order ID",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColor,
                              ),
                            ),
                            TextView(
                              config: TextViewConfig(
                                text: orderId,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        Gap(height: 20),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            ImageView(
                              imageConfig: ImageConfig(
                                imageURL: AppImage.time,
                                imageType: ImageType.svg,
                              ),
                            ),
                            Gap(width: 8),
                            TextView(
                              config: TextViewConfig(
                                text: "Estimated: 25 - 35 minutes",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),
                        Gap(height: 20),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            ImageView(
                              imageConfig: ImageConfig(
                                imageURL: AppImage.locatorIndicator,
                                imageType: ImageType.svg,
                              ),
                            ),
                            Gap(width: 8),
                            TextView(
                              config: TextViewConfig(
                                text: address,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(height: 31),
                  // ButtonWidget(
                  //   config: ButtonConfig(
                  //     text: "Track Order",
                  //     onPressed: () {
                  //       // PageRouter.pushNamed(
                  //       //   Routes.orderTrackingView,
                  //       //   args: OrderTrackingViewArguments(
                  //       //     orderId: orderId.toString(),
                  //       //     orderInfo: order,
                  //       //   ),
                  //       // );
                  //     },
                  //     //  model.placeOrder(),
                  //     height: 50,
                  //     radius: 18.r,
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w800,
                  //     textColor: AppColors.white,
                  //   ),
                  // ),
                  // Gap(height: 16),
                  ButtonWidget(
                    config: ButtonConfig(
                      text: "Back to menu",
                      onPressed: () =>
                          PageRouter.pushReplacement(Routes.dashboardView),
                      //  model.placeOrder(),
                      height: 50,
                      radius: 18.r,
                      buttonColor: AppColors.yellow500,
                      buttonOutlinedColor: AppColors.yellow500,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      textColor: AppColors.white,
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
