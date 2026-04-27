// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String EmailValueKey = 'email';
const String FullnameValueKey = 'fullname';
const String PasswordValueKey = 'password';
const String ConfPasswordValueKey = 'confPassword';

final Map<String, TextEditingController> _RegisterViewTextEditingControllers =
    {};

final Map<String, FocusNode> _RegisterViewFocusNodes = {};

final Map<String, String? Function(String?)?> _RegisterViewTextValidations = {
  EmailValueKey: null,
  FullnameValueKey: null,
  PasswordValueKey: null,
  ConfPasswordValueKey: null,
};

mixin $RegisterView {
  TextEditingController get emailController =>
      _getFormTextEditingController(EmailValueKey);
  TextEditingController get fullnameController =>
      _getFormTextEditingController(FullnameValueKey);
  TextEditingController get passwordController =>
      _getFormTextEditingController(PasswordValueKey);
  TextEditingController get confPasswordController =>
      _getFormTextEditingController(ConfPasswordValueKey);

  FocusNode get emailFocusNode => _getFormFocusNode(EmailValueKey);
  FocusNode get fullnameFocusNode => _getFormFocusNode(FullnameValueKey);
  FocusNode get passwordFocusNode => _getFormFocusNode(PasswordValueKey);
  FocusNode get confPasswordFocusNode =>
      _getFormFocusNode(ConfPasswordValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_RegisterViewTextEditingControllers.containsKey(key)) {
      return _RegisterViewTextEditingControllers[key]!;
    }

    _RegisterViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _RegisterViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_RegisterViewFocusNodes.containsKey(key)) {
      return _RegisterViewFocusNodes[key]!;
    }
    _RegisterViewFocusNodes[key] = FocusNode();
    return _RegisterViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    emailController.addListener(() => _updateFormData(model));
    fullnameController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    confPasswordController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    emailController.addListener(() => _updateFormData(model));
    fullnameController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    confPasswordController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          EmailValueKey: emailController.text,
          FullnameValueKey: fullnameController.text,
          PasswordValueKey: passwordController.text,
          ConfPasswordValueKey: confPasswordController.text,
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

    for (var controller in _RegisterViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _RegisterViewFocusNodes.values) {
      focusNode.dispose();
    }

    _RegisterViewTextEditingControllers.clear();
    _RegisterViewFocusNodes.clear();
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

  String? get emailValue => this.formValueMap[EmailValueKey] as String?;
  String? get fullnameValue => this.formValueMap[FullnameValueKey] as String?;
  String? get passwordValue => this.formValueMap[PasswordValueKey] as String?;
  String? get confPasswordValue =>
      this.formValueMap[ConfPasswordValueKey] as String?;

  set emailValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EmailValueKey: value}),
    );

    if (_RegisterViewTextEditingControllers.containsKey(EmailValueKey)) {
      _RegisterViewTextEditingControllers[EmailValueKey]?.text = value ?? '';
    }
  }

  set fullnameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({FullnameValueKey: value}),
    );

    if (_RegisterViewTextEditingControllers.containsKey(FullnameValueKey)) {
      _RegisterViewTextEditingControllers[FullnameValueKey]?.text = value ?? '';
    }
  }

  set passwordValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PasswordValueKey: value}),
    );

    if (_RegisterViewTextEditingControllers.containsKey(PasswordValueKey)) {
      _RegisterViewTextEditingControllers[PasswordValueKey]?.text = value ?? '';
    }
  }

  set confPasswordValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ConfPasswordValueKey: value}),
    );

    if (_RegisterViewTextEditingControllers.containsKey(ConfPasswordValueKey)) {
      _RegisterViewTextEditingControllers[ConfPasswordValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasEmail =>
      this.formValueMap.containsKey(EmailValueKey) &&
      (emailValue?.isNotEmpty ?? false);
  bool get hasFullname =>
      this.formValueMap.containsKey(FullnameValueKey) &&
      (fullnameValue?.isNotEmpty ?? false);
  bool get hasPassword =>
      this.formValueMap.containsKey(PasswordValueKey) &&
      (passwordValue?.isNotEmpty ?? false);
  bool get hasConfPassword =>
      this.formValueMap.containsKey(ConfPasswordValueKey) &&
      (confPasswordValue?.isNotEmpty ?? false);

  bool get hasEmailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey]?.isNotEmpty ?? false;
  bool get hasFullnameValidationMessage =>
      this.fieldsValidationMessages[FullnameValueKey]?.isNotEmpty ?? false;
  bool get hasPasswordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey]?.isNotEmpty ?? false;
  bool get hasConfPasswordValidationMessage =>
      this.fieldsValidationMessages[ConfPasswordValueKey]?.isNotEmpty ?? false;

  String? get emailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey];
  String? get fullnameValidationMessage =>
      this.fieldsValidationMessages[FullnameValueKey];
  String? get passwordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey];
  String? get confPasswordValidationMessage =>
      this.fieldsValidationMessages[ConfPasswordValueKey];
}

extension Methods on FormStateHelper {
  setEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailValueKey] = validationMessage;
  setFullnameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[FullnameValueKey] = validationMessage;
  setPasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PasswordValueKey] = validationMessage;
  setConfPasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ConfPasswordValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    emailValue = '';
    fullnameValue = '';
    passwordValue = '';
    confPasswordValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      EmailValueKey: getValidationMessage(EmailValueKey),
      FullnameValueKey: getValidationMessage(FullnameValueKey),
      PasswordValueKey: getValidationMessage(PasswordValueKey),
      ConfPasswordValueKey: getValidationMessage(ConfPasswordValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _RegisterViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _RegisterViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      EmailValueKey: getValidationMessage(EmailValueKey),
      FullnameValueKey: getValidationMessage(FullnameValueKey),
      PasswordValueKey: getValidationMessage(PasswordValueKey),
      ConfPasswordValueKey: getValidationMessage(ConfPasswordValueKey),
    });
