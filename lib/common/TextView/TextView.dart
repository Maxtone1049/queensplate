import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Models/TextViewConfig.dart';

class TextView extends StatelessWidget {
  final TextViewConfig config;

  const TextView({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: config.onTap,
      child: Text(
        config.text,
        style:
            config.textStyle ??
            GoogleFonts.dmSans(
              color: config.color,
              shadows: config.shadows,
              decoration: config.decoration,
              decorationStyle: config.decorationStyle,
              decorationThickness: config.decorationThickness,
              fontWeight: config.fontWeight,
              fontSize: config.fontSize?.sp,
              fontStyle: config.fontStyle,
              height: config.lineHeight,
              wordSpacing: config.wordSpacing,
              letterSpacing: config.letterSpacing,
            ),
        textAlign: config.textAlign,
        overflow: config.textOverflow,
        maxLines: config.maxLines,
      ),
    );
  }
}
