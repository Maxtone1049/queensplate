import 'package:flutter/material.dart';
import 'package:queen_plate_delivery/Common/Gap.dart';
import 'package:queen_plate_delivery/Common/Image/ImageView.dart';
import 'package:queen_plate_delivery/Common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/Common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/Common/TextView/TextView.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';

class MealCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final Function() tap;

  const MealCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.76, horizontal: 8.76),
        decoration: BoxDecoration(
          color: AppColors.red50,
          borderRadius: BorderRadius.circular(21),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ImageView(
                  imageConfig: ImageConfig(
                    imageURL: imageUrl,
                    imageType: ImageType.network,
                    boxFit: BoxFit.cover,
                    height: 120,
                  ),
                ),
              ),
            ),
            Gap(height: 10),
            TextView(
              config: TextViewConfig(
                text: title,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.textColor,
                maxLines: 2,
              ),
            ),
            Gap(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  config: TextViewConfig(
                    text: price,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: AppColors.primary,
                    maxLines: 2,
                  ),
                ),

                ImageView(
                  imageConfig: ImageConfig(
                    imageURL: AppImage.cart,
                    imageType: ImageType.svg,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
