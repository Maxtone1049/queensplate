import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';

class PincodeWidget extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Function(String)? onCompleted;
  final String? Function(String?)? validator;
  final double errorTextSpace;
  final bool enabled;
  final bool? hide;
  final int length;
  final double? hieght, width, radius;

  const PincodeWidget({
    super.key,
    this.focusNode,
    this.controller,
    this.onCompleted,
    this.errorTextSpace = 30,
    this.enabled = true,
    this.validator,
    required this.length,
    this.hieght,
    this.width,
    this.radius,
    this.hide,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? AppColors.black : AppColors.black;
    return PinCodeTextField(
      appContext: context,
      length: length,
      obscureText: hide ?? true,
      obscuringCharacter: '.',
      animationType: AnimationType.fade,
      scrollPadding: EdgeInsets.zero,
      cursorColor: AppColors.primary,
      autoDisposeControllers: false,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      errorTextSpace: errorTextSpace,
      enabled: enabled,
      hintStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
        color: AppColors.grey300,
        fontSize: 24,
      ),
      textStyle: Theme.of(
        context,
      ).textTheme.headlineLarge?.copyWith(color: textColor, fontSize: 24),
      keyboardType: TextInputType.none,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      animationCurve: Curves.ease,
      pinTheme: PinTheme(
        borderRadius: BorderRadius.circular(radius?.r ?? 0),
        shape: PinCodeFieldShape.box,
        fieldOuterPadding: const EdgeInsets.symmetric(horizontal: .06),
        fieldWidth: width?.h,
        fieldHeight: hieght?.h,
        activeFillColor: AppColors.primary,
        disabledColor: Color(0xffD7D7D7),
        inactiveColor: Color(0xffD7D7D7),
        inactiveFillColor: AppColors.dimgrey.withAlpha((0.2 * 255).toInt()),
        selectedColor: AppColors.shiftPrimary,
        selectedFillColor: Colors.transparent,
        activeColor: AppColors.shiftPrimary,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: controller,
      focusNode: focusNode,
      inputFormatters: [
        LengthLimitingTextInputFormatter(4),
        FilteringTextInputFormatter.digitsOnly,
      ],
      onCompleted: onCompleted,
      onChanged: (value) {},
      beforeTextPaste: (text) => true,
    );
  }
}
