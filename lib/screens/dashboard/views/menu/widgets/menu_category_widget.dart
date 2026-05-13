import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/common/Gap.dart';
import 'package:queen_plate_delivery/common/Image/ImageView.dart';
import 'package:queen_plate_delivery/common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/common/TextView/TextView.dart';

class MenuCategoryWidget extends StatelessWidget {
  const MenuCategoryWidget({
    super.key,
    required this.image,
    required this.catname,
    this.isSelected = false,
    required this.onTap,
  });
  final bool isSelected;
  final VoidCallback onTap;
  final String image, catname;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 10.w),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: isSelected ? 2.w : 2.w,
                  color: isSelected ? AppColors.primary : AppColors.grey1100,
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: ImageView(
                  imageConfig: ImageConfig(
                    imageURL: image,
                    imageType: image.contains("https")
                        ? ImageType.network
                        : ImageType.svg,
                    height: 60,
                  ),
                ),
              ),
            ),
            Gap(height: 8),
            TextView(
              config: TextViewConfig(
                text: catname,
                color: isSelected ? AppColors.primary : AppColors.black,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
