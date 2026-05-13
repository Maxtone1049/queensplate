import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/Gap.dart';
import 'package:queen_plate_delivery/common/Image/ImageView.dart';
import 'package:queen_plate_delivery/common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/common/TextView/TextView.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/home/widgets/quantity_button.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.image,
    required this.itemName,
    required this.price,
    required this.quantity,
    required this.totalPrice,
    required this.increase,
    required this.decrease,
    required this.delete,
  });
  final String image, itemName, price, quantity, totalPrice;
  final Function() increase, decrease, delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 13.80, horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(
          width: 1,
          color: AppColors.borderLine.withAlpha((0.41 * 225).toInt()),
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: ImageView(
              imageConfig: ImageConfig(
                imageURL: image,
                imageType: ImageType.network,
                height: 100,
                width: 100,
              ),
            ),
          ),
          Gap(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  config: TextViewConfig(
                    text: itemName,
                    color: AppColors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    TextView(
                      config: TextViewConfig(
                        text: "₦$price",
                        color: AppColors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextView(
                      config: TextViewConfig(
                        text: " each",
                        color: AppColors.primary,
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Gap(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        QuantityButton(icon: Icons.remove, onTap: decrease),
                        Container(
                          width: 40,
                          alignment: Alignment.center,
                          child: TextView(
                            config: TextViewConfig(
                              text: quantity,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        QuantityButton(icon: Icons.add_circle, onTap: increase),
                      ],
                    ),
                    Row(
                      children: [
                        TextView(
                          config: TextViewConfig(
                            text: "₦$totalPrice",
                            color: AppColors.primary,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Gap(width: 4),
                        ImageView(
                          imageConfig: ImageConfig(
                            imageURL: AppImage.delete,
                            imageType: ImageType.svg,
                            onTap: delete,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
