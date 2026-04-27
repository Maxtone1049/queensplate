import 'package:flutter/material.dart';

import '../../../assets/app_colors.dart';

enum ButtonType { fill, outlined }

class ButtonConfig {
  final Function()? onPressed;
  final String text;
  final double? height;
  final double? width;
  final double? borderWidth;
  bool loading;
  final Color? buttonColor;
  final Color? buttonOutlinedColor;
  final Color? textColor;
  final double? fontSize;
  final ButtonType? buttonType;
  final String? icon;
  final double? radius;
  final double? elevation;
  final bool enabled;
  final Color? loaderColor;
  final FontWeight? fontWeight;

  ButtonConfig({
    required this.text,
    required this.onPressed,
    this.height = 40,
    this.fontWeight,
    this.width,
    this.borderWidth,
    this.loading = false,
    this.enabled = true,
    this.buttonType = ButtonType.fill,
    this.buttonColor = AppColors.primary,
    this.buttonOutlinedColor = AppColors.primary,
    this.textColor = AppColors.white,
    this.icon,
    this.elevation,
    this.fontSize,
    this.loaderColor = AppColors.white,
    this.radius = 10,
  });
}
