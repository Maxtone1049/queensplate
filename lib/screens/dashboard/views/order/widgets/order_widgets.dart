import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/common/Gap.dart';
import 'package:queen_plate_delivery/common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/common/TextView/TextView.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/order_history_res_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/cart_view_model.dart';

// Order Card
Widget buildOrderCard(OrderData order, CartViewModel model, Function()? tap) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(width: 1, color: AppColors.yellow100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView(
              config: TextViewConfig(
                text: order.orderNumber.toString(),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            TextView(
              config: TextViewConfig(
                text: order.status
                    .toString()
                    .split(" ")
                    .first
                    .toUpperCase()
                    .replaceAll("_", " "),
                fontSize: 14.sp,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Gap(height: 8.h),
        Row(
          children: [
            TextView(
              config: TextViewConfig(
                text: order.updatedAt!.toIso8601String(),
                fontSize: 10,
                color: AppColors.textColor,
              ),
            ),
            Gap(width: 8.w),
            TextView(
              config: TextViewConfig(
                text: "${order.items.length} items",
                fontSize: 10,
                color: AppColors.yellow500,
              ),
            ),
          ],
        ),
        Gap(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView(
              config: TextViewConfig(
                text: "₦${order.totalAmount.toString()}",
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
            // TODO: work on this reoder button logic to let user reorder
            // GestureDetector(
            //   onTap: tap,
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            //     decoration: BoxDecoration(
            //       color: AppColors.yellow50,
            //       borderRadius: BorderRadius.circular(14.r),
            //     ),
            //     child: Row(
            //       children: [
            //         ImageView(
            //           imageConfig: ImageConfig(
            //             imageURL: AppImage.retry,
            //             imageType: ImageType.svg,
            //           ),
            //         ),
            //         TextView(
            //           config: TextViewConfig(
            //             text: "Reorder",
            //             fontSize: 11,
            //             color: AppColors.yellow500,
            //             fontWeight: FontWeight.w400,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ],
    ),
  );
}
