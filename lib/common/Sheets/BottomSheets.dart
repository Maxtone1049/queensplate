import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../assets/app_colors.dart';

class BottomSheets {
  static Future<T?> showSheet<T>(
    BuildContext context, {
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    Color backgroundColor = AppColors.kcDarkGreenColor,
  }) {
    return showModalBottomSheet<T>(
      isDismissible: isDismissible,
      isScrollControlled: true,
      backgroundColor: backgroundColor,
      enableDrag: enableDrag,
      elevation: 100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      context: context,
      builder: (_) {
        return Wrap(children: [child]);
      },
    );
  }
}
