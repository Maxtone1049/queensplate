import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/core/theme/styles.dart';




ThemeData darkTheme = ThemeData.light(useMaterial3: false).copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: AppColors.darkScaffold,
  iconTheme: const IconThemeData(size: 24),
  canvasColor: AppColors.white,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  brightness: Brightness.dark,
  dividerTheme:
      const DividerThemeData(thickness: 1, color: AppColors.borderColor100),
  textSelectionTheme:
      const TextSelectionThemeData(cursorColor: AppColors.white),
  appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(color: AppColors.primary),
      titleTextStyle: headlineLarge.copyWith(
          color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w600)),
  primaryTextTheme: const TextTheme(),
  textTheme: TextTheme(
      headlineLarge: headlineLarge.copyWith(color: AppColors.white),
      bodySmall: bodySmall,
      bodyMedium: bodyMedium.copyWith(color: AppColors.grey200),
      titleLarge: titleLarge,
      labelSmall: labelSmall,
      labelLarge: labelLarge.copyWith(color: AppColors.white),
      titleMedium: titleMedium.copyWith(color: AppColors.white)),
  cardColor: AppColors.grey500,
  colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.darkPrimary,
          onPrimary: AppColors.primary,
          secondary: Colors.blue,
          onSecondary: Colors.yellow,
          error: Colors.red,
          onError: Colors.redAccent,
          surface: AppColors.primary,
          onSurface: Color.fromRGBO(36, 36, 36, 1))
      .copyWith(surface: Colors.black),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          elevation: WidgetStateProperty.resolveWith((states) => 0),
          enableFeedback: true,
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.grey400;
            }
            return AppColors.green;
          }),
          textStyle: WidgetStateProperty.resolveWith((states) =>
              GoogleFonts.instrumentSans(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          shape: WidgetStateProperty.resolveWith((states) =>
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          foregroundColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) return AppColors.text;

            return AppColors.white;
          }),
          side: WidgetStateBorderSide.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return const BorderSide(color: AppColors.grey400);
            }
            return const BorderSide(color: AppColors.green);
          }))),
  outlinedButtonTheme: const OutlinedButtonThemeData(),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: bodyMedium.copyWith(
        overflow: TextOverflow.ellipsis,
        color: AppColors.title,
        fontWeight: FontWeight.w500),
    hintStyle: bodyMedium.copyWith(
        color: AppColors.title, fontWeight: FontWeight.w500),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: Colors.transparent,
    filled: true,
    errorMaxLines: 5,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    errorStyle: bodyMedium.copyWith(
        color: AppColors.red500,
        fontSize: 12,
        overflow: TextOverflow.visible),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.borderColor100)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.red500)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.green)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.borderColor100)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.red500)),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.borderColor100)),
  ),
  cupertinoOverrideTheme: const CupertinoThemeData(
      primaryColor: AppColors.green,
      barBackgroundColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.white,
      textTheme: CupertinoTextThemeData(
        primaryColor: AppColors.green,
        textStyle: TextStyle(color: AppColors.white, fontSize: 14),
      )),
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(backgroundColor: AppColors.grey200),
  bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.grey500,
      modalBarrierColor:
          const Color.fromRGBO(117, 117, 126, 1).withValues(alpha: .40),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)))),
  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.grey200,
    barrierColor: const Color.fromRGBO(117, 117, 126, 1).withValues(alpha: .40),
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    insetPadding: const EdgeInsets.symmetric(),
  ),
  datePickerTheme: const DatePickerThemeData(),
  switchTheme: const SwitchThemeData(),
  tabBarTheme: TabBarThemeData(
      labelColor: AppColors.green,
      indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(2), color: AppColors.grey400),
      unselectedLabelColor: AppColors.grey100,
      indicatorColor: AppColors.green,
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelStyle:
          titleLarge.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
      labelStyle:
          titleLarge.copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
  expansionTileTheme: const ExpansionTileThemeData(
    tilePadding: EdgeInsets.zero,
    childrenPadding: EdgeInsets.zero,
    expandedAlignment: Alignment.centerLeft,
    textColor: AppColors.white,
    collapsedIconColor: AppColors.white,
    collapsedTextColor: AppColors.white,
    iconColor: AppColors.white,
    collapsedShape: RoundedRectangleBorder(),
    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
  ),
);
