import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';


ThemeData get appLightTheme => ThemeData.light().copyWith(
  scaffoldBackgroundColor: AppColors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.white,
    elevation: .5,
  ),
  applyElevationOverlayColor: true,
  brightness: Brightness.light,
  textTheme: GoogleFonts.workSansTextTheme(
    TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.grey900,
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ),
      headlineMedium: TextStyle(
        color: AppColors.grey900,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ),
      bodyMedium: TextStyle(
        color: AppColors.grey500,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),
  ),
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.darkerPrimary,
    error: Colors.red,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all(.2),
      animationDuration: const Duration(milliseconds: 300),
      fixedSize: WidgetStateProperty.all(Size(double.infinity.w, 40.h)),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.white70;
        }

        if (states.contains(WidgetState.error)) {
          return AppColors.red500;
        }
        return AppColors.white;
      }),
      enableFeedback: true,
      side: WidgetStateBorderSide.resolveWith(
        (states) => const BorderSide(width: 1, color: AppColors.grey300),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      ),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all(.2),
      animationDuration: const Duration(milliseconds: 300),
      fixedSize: WidgetStateProperty.all(Size(double.infinity.w, 40.h)),
      textStyle: WidgetStateTextStyle.resolveWith((states) {
        return TextStyle(
          color: AppColors.primary,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        );
      }),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.darkPrimary;
        }
        if (states.contains(WidgetState.pressed)) {
          return AppColors.primary;
        }
        if (states.contains(WidgetState.focused)) {
          return AppColors.primary;
        }
        if (states.contains(WidgetState.error)) {
          return AppColors.red500;
        }
        return AppColors.primary;
      }),
      enableFeedback: true,
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r),
          side: const BorderSide(color: AppColors.primary, width: .2),
        ),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    suffixIconColor: AppColors.primary,
    errorStyle: GoogleFonts.roboto(
      color: AppColors.red500,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
    floatingLabelAlignment: FloatingLabelAlignment.start,
    labelStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 16.sp,
      color: AppColors.secondary,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    focusedErrorBorder: InputBorder.none,
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: AppColors.primary),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: AppColors.grey300),
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: AppColors.grey300),
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: AppColors.primary),
    ),
  ),
);

ThemeData get appDarkTheme => ThemeData.dark().copyWith();
