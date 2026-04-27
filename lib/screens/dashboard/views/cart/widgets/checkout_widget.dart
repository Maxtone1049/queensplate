import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/common/Image/ImageView.dart';
import 'package:queen_plate_delivery/common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/common/TextView/TextView.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/cart_view_model.dart';

Widget buildOrderItem(String name, int qty, int price) {
  return Padding(
    padding: EdgeInsets.only(bottom: 12.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "${qty}x ",
                  style: GoogleFonts.dmSans(
                    color: AppColors.yellow500,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: name,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        TextView(
          config: TextViewConfig(
            text: "₦$price",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget buildSummaryRow(String title, String amount) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextView(
        config: TextViewConfig(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      TextView(
        config: TextViewConfig(
          text: amount,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

// Selectable Payment Option
Widget buildPaymentOption({
  required CartViewModel model,
  required String type,
  required String iconPath,
}) {
  final isSelected = model.selectedPaymentMethod == type;

  return GestureDetector(
    onTap: () => model.selectPaymentMethod(type),
    child: Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Radio<String>(
            value: type,
            groupValue: model.selectedPaymentMethod,
            onChanged: (val) => model.selectPaymentMethod(val!),
            activeColor: AppColors.primary,
          ),
          ImageView(
            imageConfig: ImageConfig(
              imageURL: iconPath,
              imageType: ImageType.asset,
            ),
          ),
        ],
      ),
    ),
  );
}
