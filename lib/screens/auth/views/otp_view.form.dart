// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String OtpValueKey = 'otp';

final Map<String, TextEditingController> _OtpViewTextEditingControllers = {};

final Map<String, FocusNode> _OtpViewFocusNodes = {};

final Map<String, String? Function(String?)?> _OtpViewTextValidations = {
  OtpValueKey: null,
};

mixin $OtpView {
  TextEditingController get otpController =>
      _getFormTextEditingController(OtpValueKey);

  FocusNode get otpFocusNode => _getFormFocusNode(OtpValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_OtpViewTextEditingControllers.containsKey(key)) {
      return _OtpViewTextEditingControllers[key]!;
    }

    _OtpViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _OtpViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_OtpViewFocusNodes.containsKey(key)) {
      return _OtpViewFocusNodes[key]!;
    }
    _OtpViewFocusNodes[key] = FocusNode();
    return _OtpViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    otpController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    otpController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          OtpValueKey: otpController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _OtpViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _OtpViewFocusNodes.values) {
      focusNode.dispose();
    }

    _OtpViewTextEditingControllers.clear();
    _OtpViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get otpValue => this.formValueMap[OtpValueKey] as String?;

  set otpValue(String? value) {
    this.setData(
      this.formValueMap..addAll({OtpValueKey: value}),
    );

    if (_OtpViewTextEditingControllers.containsKey(OtpValueKey)) {
      _OtpViewTextEditingControllers[OtpValueKey]?.text = value ?? '';
    }
  }

  bool get hasOtp =>
      this.formValueMap.containsKey(OtpValueKey) &&
      (otpValue?.isNotEmpty ?? false);

  bool get hasOtpValidationMessage =>
      this.fieldsValidationMessages[OtpValueKey]?.isNotEmpty ?? false;

  String? get otpValidationMessage =>
      this.fieldsValidationMessages[OtpValueKey];
}

extension Methods on FormStateHelper {
  setOtpValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[OtpValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    otpValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      OtpValueKey: getValidationMessage(OtpValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _OtpViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _OtpViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      OtpValueKey: getValidationMessage(OtpValueKey),
    });
