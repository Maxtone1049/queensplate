import 'package:queen_plate_delivery/common/TextView/Models/TextViewConfig.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';

import '../../assets/app_colors.dart';
import '../Gap.dart';
import '../TextView/TextView.dart';
import 'Model/PhoneFieldConfig.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

// ignore: must_be_immutable
class PhoneFieldView extends StatefulWidget {
  const PhoneFieldView({super.key, required this.config});

  final PhoneFieldConfig config;

  @override
  State<PhoneFieldView> createState() => _PhoneFieldViewState();
}

class _PhoneFieldViewState extends State<PhoneFieldView> {
  bool _hasFocus = false;
  bool get hasFocus => _hasFocus;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.config.title != null)
          Row(
            children: [
              Flexible(
                child: TextView(
                  config: TextViewConfig(
                    text: widget.config.title ?? '',
                    textStyle: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(fontSize: 14.sp),
                  ),
                ),
              ),
              if (widget.config.isRequired) const Gap(width: 3),
              if (widget.config.isRequired)
                TextView(
                  config: TextViewConfig(
                    text: '*',
                    textStyle: Theme.of(context).textTheme.headlineMedium
                        ?.copyWith(fontSize: 16.sp, color: AppColors.primary),
                  ),
                ),
              if (widget.config.hintRight != null) const Spacer(),
              if (widget.config.hintRight != null)
                TextView(
                  config: TextViewConfig(
                    text: widget.config.hintRight ?? '',
                    fontSize: 12,
                    textAlign: TextAlign.right,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        if (widget.config.title != null) const Gap(height: 8),
        Focus(
          onFocusChange: (v) => setState(() => _hasFocus = v),
          child: Container(
            padding:
                !_hasFocus
                    ? EdgeInsets.zero
                    : EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: _hasFocus ? AppColors.accent.withOpacity(.2) : null,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: IntlPhoneField(
              readOnly: widget.config.readOnly!,
              onTap: widget.config.onTapped,
              key: widget.config.formKey,
              cursorColor: AppColors.primary,
              keyboardType: widget.config.keyboardType,
              enabled: widget.config.enabled,
              showDropdownIcon: widget.config.showDropdownIcon,
              focusNode: widget.config.focusNode,
              initialCountryCode: widget.config.initialCountryCode,
              textInputAction: widget.config.textInputAction,
              autovalidateMode: widget.config.autoValidateMode,
              onSaved: widget.config.onSaved,
              onChanged: widget.config.onChange,
              flagsButtonMargin: widget.config.flagsButtonMargin,
              inputFormatters: widget.config.inputFormatters,
              obscureText: widget.config.obscureText!,
              disableLengthCheck: widget.config.maxLength,
              validator: widget.config.validator,
              initialValue: widget.config.initialValue,
              controller: widget.config.controller,
              textAlign: widget.config.textAlign,
              style:
                  widget.config.textStyle ??
                  TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
              decoration:
                  widget.config.decoration ??
                  InputDecoration(
                    labelText: widget.config.label,
                    hintStyle: widget.config.hintStyle,
                    labelStyle: widget.config.labelStyle,
                    filled: widget.config.filled,
                    fillColor: widget.config.filledColor,
                    prefix: widget.config.prefixWidget,
                    prefixIcon: widget.config.prefixIconWidget,
                    hintText: widget.config.hint,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        widget.config.radius.r,
                      ),
                      borderSide: const BorderSide(
                        color: AppColors.accent,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        widget.config.radius.r,
                      ),
                      borderSide: const BorderSide(color: AppColors.grey300),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        widget.config.radius.r,
                      ),
                      borderSide: const BorderSide(color: AppColors.grey300),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        widget.config.radius.r,
                      ),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        widget.config.radius.r,
                      ),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        widget.config.radius.r,
                      ),
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
                    floatingLabelBehavior: widget.config.floatingLabelBehavior,
                    alignLabelWithHint: widget.config.alignLabelWithHint,
                    contentPadding: widget.config.edgeInsetsGeometry,
                    suffixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: widget.config.suffixIconWidget,
                    ),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
