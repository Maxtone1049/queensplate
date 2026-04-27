import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';

class EditFieldConfig {
  final double? height;
  final TextCapitalization? textCapitalization;
  final String? label;
  final String? floatingLabel;
  final String? hint;
  final String? title;
  final Color? titleColor;
  final String? hintRight;
  final Widget? prefixIconWidget;
  final Widget? suffixIconWidget;
  final Widget? prefixWidget;
  final Widget? suffixWidget;

  final FormFieldSetter<String>? onSaved;
  final Function(String)? onChange;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onPasswordToggle;

  final String? initialValue;
  final TextEditingController? controller;
  final FloatingLabelBehavior? floatingLabelBehavior;

  final bool? autocorrect;
  final AutovalidateMode? autoValidateMode;
  final bool? enabled;
  final bool? obscureText;
  final bool? readOnly;
  final bool? alignLabelWithHint;
  final bool? isTyping;

  final bool? clickable;
  final bool isRequired;
  final Function()? onTapped;

  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  final Color? focusedColorBorder;
  final Color? bgColor;
  final Color? suffixIconColor;
  final Color? prefixIconColor;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextInputAction? textInputAction;
  final InputDecoration? decoration;
  final Key? formKey;

  final EdgeInsetsGeometry? edgeInsetsGeometry;
  final FocusNode? focusNode;
  final bool filled;
  final bool autoValidate;
  final bool showMaxLengthCounter;
  final int counterLength;
  final double radius;

  final Color? filledColor;
  final TextAlign textAlign;

  final ThemeData? themeData;

  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? border;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;

  EditFieldConfig({
    Key? key,
    this.label = '',
    this.hint,
    this.title,
    this.titleColor,
    this.floatingLabel = '',
    this.prefixIconWidget,
    this.suffixIconWidget,
    this.onSaved,
    this.validator,
    this.controller,
    this.isRequired = false,
    this.alignLabelWithHint = false,
    this.onPasswordToggle,
    this.initialValue,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.autocorrect = true,
    this.enabled = true,
    this.obscureText = false,
    this.readOnly = false,
    this.themeData,
    this.onTapped,
    this.keyboardType,
    this.textAlign = TextAlign.left,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.hintRight,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.inputFormatters,
    this.focusedColorBorder,
    this.suffixIconColor,
    this.labelStyle,
    this.hintStyle,
    this.textStyle,
    this.decoration,
    this.onChange,
    this.edgeInsetsGeometry,
    this.textCapitalization = TextCapitalization.none,
    this.formKey,
    this.bgColor,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.clickable,
    this.prefixWidget,
    this.prefixIconColor,
    this.filled = true,
    this.counterLength = 0,
    this.isTyping = false,
    this.autoValidate = false,
    this.suffixWidget,
    this.height,
    this.filledColor = AppColors.white,
    this.showMaxLengthCounter = false,
    this.radius = 8,
    this.focusedBorder,
    this.enabledBorder,
    this.border,
    this.errorBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
  });
}
