import 'package:flutter/material.dart';
import 'package:queen_plate_delivery/Common/Gap.dart';
import 'package:queen_plate_delivery/Common/Image/ImageView.dart';
import 'package:queen_plate_delivery/Common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/Common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/Common/TextView/TextView.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/AppUtils/app_helpers.dart';
import 'package:url_launcher/url_launcher.dart';

class OutdoorServiceWidget extends StatelessWidget {
  const OutdoorServiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var uri = 'https://wa.me/+2348167934957';
        AppHelpers.launchURL(Uri.parse(uri), mode: LaunchMode.platformDefault);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primary.withAlpha((0.05 * 225).toInt()),
          borderRadius: BorderRadius.circular(11.29),
          border: Border.all(
            color: AppColors.primary.withAlpha((0.20 * 225).toInt()),
          ),
        ),
        child: Row(
          children: [
            ImageView(
              imageConfig: ImageConfig(
                imageURL: AppImage.firedup,
                imageType: ImageType.svg,
              ),
            ),

            Gap(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    config: TextViewConfig(
                      text: "Outdoor Catering",
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  TextView(
                    config: TextViewConfig(
                      text:
                          "Chat with us for custom catering menus and event services",
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
            ),
            ImageView(
              imageConfig: ImageConfig(
                imageURL: AppImage.message,
                imageType: ImageType.svg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
