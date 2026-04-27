import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../assets/app_colors.dart';
import '../../assets/app_fonts.dart';
import 'CircularProgressLoader.dart';

class BeingProgressIndicator extends StatelessWidget {
  const BeingProgressIndicator({super.key, required this.valueNotifier});

  final ValueNotifier<double> valueNotifier;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46.h,
      width: 46.w,
      child: CircularProgressLoader(
        progressColors: const [
          AppColors.primaryDim,
          AppColors.primaryLight,
          AppColors.primary,
        ],
        fullProgressColor: AppColors.primary,
        backStrokeWidth: 2,
        progressStrokeWidth: 2,
        backColor: AppColors.lightGrey,
        mergeMode: true,
        valueNotifier: valueNotifier,
        maxValue: 300,
        onGetText: (double value) {
          return Text(
            '${value.toInt()}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: AppFonts.interdisplay,
              color: AppColors.accent,
            ),
          );
        },
      ),
    );
  }
}
