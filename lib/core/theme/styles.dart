import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';

TextStyle get headlineLarge => GoogleFonts.workSans(
  color: AppColors.primaryLight,
  fontWeight: FontWeight.w700,
  fontSize: 34,
);

TextStyle get bodySmall => GoogleFonts.workSans(
  color: AppColors.primaryLight,
  fontWeight: FontWeight.w400,
  fontSize: 10,
);

TextStyle get bodyMedium => GoogleFonts.workSans(
  color: AppColors.text,
  fontWeight: FontWeight.w400,
  fontSize: 14,
);

TextStyle get titleLarge => GoogleFonts.workSans(
  color: AppColors.black,
  fontWeight: FontWeight.w400,
  fontSize: 14,
);

TextStyle get labelSmall => GoogleFonts.workSans(
  color: AppColors.black,
  fontWeight: FontWeight.w400,
  fontSize: 14,
);

TextStyle get titleMedium => GoogleFonts.workSans(
  color: AppColors.primaryLight,
  fontWeight: FontWeight.w400,
  fontSize: 14,
);

TextStyle get labelLarge => GoogleFonts.roboto(
  color: AppColors.primaryLight,
  fontWeight: FontWeight.w400,
  fontSize: 14,
);
