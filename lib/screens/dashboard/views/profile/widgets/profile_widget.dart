import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/Gap.dart';
import 'package:queen_plate_delivery/common/Image/ImageView.dart';
import 'package:queen_plate_delivery/common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/common/TextView/TextView.dart';

Widget buildDetailCard({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onCopy,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          ImageView(
            imageConfig: ImageConfig(imageURL: icon, imageType: ImageType.svg),
          ),
          Gap(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  config: TextViewConfig(
                    text: title,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(height: 4),
                TextView(
                  config: TextViewConfig(
                    text: subtitle,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          ImageView(
            imageConfig: ImageConfig(
              imageURL: AppImage.copy,
              imageType: ImageType.svg,
              onTap: onCopy,
            ),
          ),
        ],
      ),
    );
  }