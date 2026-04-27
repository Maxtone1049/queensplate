import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';

import '../assets/app_colors.dart';
import '../assets/app_image.dart';
import 'Gap.dart';
import 'Image/ImageView.dart';
import 'Image/Model/ImageConfig.dart';
import 'TextView/Models/TextViewConfig.dart';
import 'TextView/TextView.dart';

class MessageNotification extends StatefulWidget {
  final String message;
  final bool error;

  const MessageNotification({
    Key? key,
    required this.message,
    this.error = false,
  }) : super(key: key);

  @override
  State<MessageNotification> createState() => _MessageNotificationState();
}

class _MessageNotificationState extends State<MessageNotification>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.ease,
    );
    controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: GestureDetector(
        onTap: () => OverlaySupportEntry.of(context)?.dismiss(),
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: widget.error ? Colors.red : AppColors.success500,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: widget.error ? Colors.red : AppColors.success500,
            ),
          ),
          margin: EdgeInsets.only(top: kToolbarHeight, left: 10.w, right: 10.w),
          child: Material(
            color: widget.error ? Colors.red : AppColors.success500,
            borderRadius: BorderRadius.circular(16.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Row(
                children: [
                  // ImageView(
                  //   imageConfig: ImageConfig(
                  //     imageURL:
                  //         widget.error ? AppImage.finger : AppImage.finger,
                  //     imageType: ImageType.svg,
                  //     height: 30.h,
                  //     width: 30.w,
                  //   ),
                  // ),
                  // const Gap(width: 17),
                  Flexible(
                    child: TextView(
                      config: TextViewConfig(
                        text: widget.message,
                        textAlign: TextAlign.left,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: widget.error ? AppColors.white : AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
