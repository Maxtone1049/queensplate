import 'package:flutter/material.dart';

import '../../../assets/app_colors.dart';

class BodyConfig {
  final Widget? child;
  final Widget? floatingActionButton;
  final String? appBarTitle;
  final double? fontSize;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final bool showAppBar;
  final Widget? bottomNavigationBar;
  final EdgeInsetsGeometry? padding;
  final EdgeInsets? childPadding;
  final List<Widget>? tabs;
  final bool showLeadingWidget;
  final List<Widget>? actions;
  final bool loading;
  final String? leadingIcon;
  final Widget? leadingWidget;
  final double? elevation;
  final Color? appbarBackgroundColor;
  final Color? backgroundColor;
  final Color? appbarTitleColor;
  final Function()? onPressed;

  BodyConfig({
    required this.child,
    this.floatingActionButton,
    this.appBarTitle,
    this.fontSize,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
    this.showAppBar = false,
    this.bottomNavigationBar,
    this.padding,
    this.leadingWidget,
    this.childPadding,
    this.tabs,
    this.appbarBackgroundColor,
    this.backgroundColor = AppColors.white,
    this.appbarTitleColor = AppColors.grey900,
    this.elevation,
    this.showLeadingWidget = false,
    this.actions,
    this.loading = false,
    this.onPressed,
    this.leadingIcon,
  });
}
