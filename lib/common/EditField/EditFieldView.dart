import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:queen_plate_delivery/common/TextView/Models/TextViewConfig.dart';

import '../../assets/app_colors.dart';
import '../Gap.dart';
import '../TextView/TextView.dart';
import 'Model/EditFieldConfig.dart';

// ignore: must_be_immutable
class EditFormField extends StatefulWidget {
  const EditFormField({super.key, required this.config});

  final EditFieldConfig config;

  @override
  State<EditFormField> createState() => _EditFormFieldState();
}

class _EditFormFieldState extends State<EditFormField> {
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
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: TextView(
                        config: TextViewConfig(
                          text: widget.config.title ?? '',
                          textStyle: Theme.of(
                            context,
                          ).textTheme.headlineMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: widget.config.titleColor,
                          ),
                        ),
                      ),
                    ),
                    if (widget.config.isRequired) const Gap(width: 3),
                    if (widget.config.isRequired)
                      TextView(
                        config: TextViewConfig(
                          text: '*',
                          textStyle: Theme.of(
                            context,
                          ).textTheme.headlineMedium?.copyWith(
                            fontSize: 16.sp,
                            color: AppColors.red500,
                          ),
                        ),
                      ),
                  ],
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
          child: TextFormField(
            readOnly: widget.config.readOnly!,
            onTap: widget.config.onTapped,
            key: widget.config.formKey,
            cursorColor: AppColors.primary,
            keyboardType: widget.config.keyboardType,
            enabled: widget.config.enabled,
            focusNode: widget.config.focusNode,
            textInputAction: widget.config.textInputAction,
            textCapitalization: widget.config.textCapitalization!,
            autovalidateMode: widget.config.autoValidateMode,
            onSaved: widget.config.onSaved,
            onChanged: widget.config.onChange,
            maxLines: widget.config.maxLines,
            inputFormatters: widget.config.inputFormatters,
            autocorrect: widget.config.autocorrect!,
            minLines: widget.config.minLines,
            obscureText: widget.config.obscureText!,
            maxLength: widget.config.maxLength,
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
                  focusedBorder:
                      widget.config.focusedBorder ??
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          widget.config.radius.r,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                  enabledBorder:
                      widget.config.enabledBorder ??
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          widget.config.radius.r,
                        ),
                        borderSide: const BorderSide(color: AppColors.grey300),
                      ),
                  border:
                      widget.config.border ??
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          widget.config.radius.r,
                        ),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                        ),
                      ),
                  errorBorder:
                      widget.config.errorBorder ??
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          widget.config.radius.r,
                        ),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                  focusedErrorBorder:
                      widget.config.focusedErrorBorder ??
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          widget.config.radius.r,
                        ),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.config.radius.r),
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
      ],
    );
  }
}
