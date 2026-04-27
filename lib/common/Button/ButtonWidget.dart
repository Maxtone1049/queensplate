import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/common/Gap.dart';
import 'package:queen_plate_delivery/common/TextView/Models/TextViewConfig.dart';
import '../../assets/app_colors.dart';
import '../../assets/app_image.dart';
import '../Image/ImageView.dart';
import '../Image/Model/ImageConfig.dart';
import '../TextView/TextView.dart';
import 'Model/ButtonConfig.dart';

class ButtonWidget extends StatelessWidget {
  final ButtonConfig config;
  const ButtonWidget({required this.config, super.key});

  @override
  Widget build(BuildContext context) {
    if (config.buttonType == ButtonType.outlined) {
      return SizedBox(
        width: config.width?.w ?? double.infinity,
        height: config.height?.h,
        child: OutlinedButton.icon(
          onPressed: config.enabled ? config.onPressed : null,
          icon:
              config.icon != null
                  ? ImageView(imageConfig: ImageConfig(imageURL: config.icon!))
                  : const SizedBox.shrink(),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (config.loading)
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CupertinoActivityIndicator(color: config.loaderColor),
                      Gap(width: 8.w),
                    ],
                  ),
                ),
              TextView(
                config: TextViewConfig(
                  text: config.loading ? 'Please wait...' : config.text,
                  textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey900,
                    fontSize: config.fontSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(config.radius!.r),
                side: BorderSide(
                  color: config.buttonOutlinedColor!,
                  width: config.borderWidth ?? .3,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: config.width?.w ?? double.infinity,
      height: config.height?.h,
      child: FilledButton.icon(
        onPressed: config.enabled ? config.onPressed : null,
        icon:
            config.icon != null
                ? ImageView(imageConfig: ImageConfig(imageURL: config.icon!))
                : const SizedBox.shrink(),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (config.loading)
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CupertinoActivityIndicator(color: config.loaderColor),
                    Gap(width: 8.w),
                  ],
                ),
              ),
            Flexible(
              child: TextView(
                config: TextViewConfig(
                  text: config.loading ? 'Please wait...' : config.text,
                  textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: config.textColor,
                    fontSize: config.fontSize,
                    fontWeight: config.fontWeight,
                  ),
                ),
              ),
            ),
          ],
        ),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(config.buttonColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(config.radius!.r),
              side: BorderSide(color: config.buttonOutlinedColor!, width: 2.w),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomrCircleAdd extends StatelessWidget {
  const CustomrCircleAdd({super.key, required this.tap});

  final Function() tap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 50.h,
          width: 50.w,
          padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 19.h),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary),
          ),
          child: ImageView(
            imageConfig: ImageConfig(
              imageURL: AppImage.logo,
              imageType: ImageType.svg,
            ),
          ),
        ),
      ),
    );
  }
}

class AltMenuBtnWidget extends StatelessWidget {
  const AltMenuBtnWidget({Key? key, this.onPressed, this.text = 'Not now'})
    : super(key: key);

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: TextView(
        config: TextViewConfig(
          text: text,
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
