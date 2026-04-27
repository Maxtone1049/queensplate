import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';

import 'styles.dart';

ThemeData lightTheme = ThemeData.light(useMaterial3: false).copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: AppColors.white,
  iconTheme: const IconThemeData(size: 24),
  canvasColor: AppColors.white,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  brightness: Brightness.light,
  cardTheme: const CardThemeData(color: AppColors.white),
  dividerTheme: const DividerThemeData(
    thickness: 1,
    color: AppColors.darkPrimary,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.primaryLight,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    iconTheme: const IconThemeData(color: AppColors.black),
    titleTextStyle: headlineLarge.copyWith(
      color: AppColors.black,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
  primaryTextTheme: const TextTheme(),
  textTheme: TextTheme(
    headlineLarge: headlineLarge,
    bodySmall: bodySmall,
    bodyMedium: bodyMedium,
    titleLarge: titleLarge,
    labelSmall: labelSmall,
    titleMedium: titleMedium,
    labelLarge: labelLarge,
  ),
  cardColor: AppColors.white,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.white,
    onPrimary: AppColors.green,
    secondary: Colors.blue,
    onSecondary: Colors.yellow,
    error: Colors.red,
    onError: Colors.redAccent,
    surface: AppColors.green,
    onSurface: AppColors.grey100,
  ).copyWith(surface: Colors.black),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.resolveWith((states) => 0),
      enableFeedback: true,
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.grey500;
        }
        return AppColors.green;
      }),
      textStyle: WidgetStateProperty.resolveWith(
        (states) => GoogleFonts.instrumentSans(
          color: AppColors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      shape: WidgetStateProperty.resolveWith(
        (states) =>
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      foregroundColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return AppColors.text;

        return AppColors.white;
      }),
      side: WidgetStateBorderSide.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return const BorderSide(color: AppColors.grey300);
        }
        return const BorderSide(color: AppColors.green);
      }),
    ),
  ),
  outlinedButtonTheme: const OutlinedButtonThemeData(),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: bodyMedium.copyWith(
      overflow: TextOverflow.ellipsis,
      color: AppColors.black,
      fontWeight: FontWeight.w500,
    ),
    hintStyle: bodyMedium.copyWith(
      color: AppColors.black,
      fontWeight: FontWeight.w500,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: Colors.transparent,
    filled: true,
    errorMaxLines: 5,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    errorStyle: bodyMedium.copyWith(
      color: AppColors.red500,
      fontSize: 12,
      overflow: TextOverflow.visible,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.borderColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.red500),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.green),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.borderColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.red500),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.borderColor),
    ),
  ),
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: AppColors.green,
    barBackgroundColor: AppColors.white,
    scaffoldBackgroundColor: AppColors.white,
    textTheme: CupertinoTextThemeData(
      primaryColor: AppColors.green,
      textStyle: TextStyle(color: AppColors.primaryLight, fontSize: 14),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.white,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: AppColors.white,
    modalBarrierColor: const Color.fromRGBO(
      117,
      117,
      126,
      1,
    ).withValues(alpha: .40),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
  ),
  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.white,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    insetPadding: const EdgeInsets.symmetric(),
  ),
  datePickerTheme: const DatePickerThemeData(),
  switchTheme: const SwitchThemeData(),
  tabBarTheme: TabBarThemeData(
    labelColor: AppColors.green,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(2),
      color: AppColors.white,
    ),
    unselectedLabelColor: AppColors.text,
    indicatorColor: AppColors.green,
    dividerColor: Colors.transparent,
    indicatorSize: TabBarIndicatorSize.tab,
    unselectedLabelStyle: titleLarge.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    labelStyle: titleLarge.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    tilePadding: EdgeInsets.zero,
    childrenPadding: EdgeInsets.zero,
    expandedAlignment: Alignment.centerLeft,
    textColor: AppColors.primaryLight,
    collapsedIconColor: AppColors.primaryLight,
    collapsedTextColor: AppColors.primaryLight,
    iconColor: AppColors.primaryLight,
    collapsedShape: RoundedRectangleBorder(),
    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
  ),
);
