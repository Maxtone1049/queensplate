import 'package:flutter/material.dart';

class TextViewConfig {
  final String text;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final Color? color;
  final double? fontSize;
  final double? lineHeight;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Function()? onTap;
  final int? maxLines;
  final TextStyle? textStyle;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final List<Shadow>? shadows;
  final String? fontFamily;
  final double? wordSpacing;
  final double? letterSpacing;

  TextViewConfig({
    required this.text,
    this.textOverflow,
    this.textAlign,
    this.color,
    this.fontSize,
    this.lineHeight,
    this.fontWeight,
    this.fontStyle,
    this.onTap,
    this.maxLines,
    this.textStyle,
    this.decoration,
    this.decorationStyle,
    this.decorationThickness,
    this.shadows,
    this.fontFamily,
    this.wordSpacing,
    this.letterSpacing,
  });
}
