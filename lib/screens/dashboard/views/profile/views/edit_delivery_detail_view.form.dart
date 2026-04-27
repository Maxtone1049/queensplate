// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String AddressValueKey = 'address';
const String ApartmentValueKey = 'apartment';
const String CountryValueKey = 'country';
const String StateValueKey = 'state';
const String PhoneValueKey = 'phone';
const String NameValueKey = 'name';

final Map<String, TextEditingController>
    _EditDeliveryDetailViewTextEditingControllers = {};

final Map<String, FocusNode> _EditDeliveryDetailViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _EditDeliveryDetailViewTextValidations = {
  AddressValueKey: null,
  ApartmentValueKey: null,
  CountryValueKey: null,
  StateValueKey: null,
  PhoneValueKey: null,
  NameValueKey: null,
};

mixin $EditDeliveryDetailView {
  TextEditingController get addressController =>
      _getFormTextEditingController(AddressValueKey);
  TextEditingController get apartmentController =>
      _getFormTextEditingController(ApartmentValueKey);
  TextEditingController get countryController =>
      _getFormTextEditingController(CountryValueKey);
  TextEditingController get stateController =>
      _getFormTextEditingController(StateValueKey);
  TextEditingController get phoneController =>
      _getFormTextEditingController(PhoneValueKey);
  TextEditingController get nameController =>
      _getFormTextEditingController(NameValueKey);

  FocusNode get addressFocusNode => _getFormFocusNode(AddressValueKey);
  FocusNode get apartmentFocusNode => _getFormFocusNode(ApartmentValueKey);
  FocusNode get countryFocusNode => _getFormFocusNode(CountryValueKey);
  FocusNode get stateFocusNode => _getFormFocusNode(StateValueKey);
  FocusNode get phoneFocusNode => _getFormFocusNode(PhoneValueKey);
  FocusNode get nameFocusNode => _getFormFocusNode(NameValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_EditDeliveryDetailViewTextEditingControllers.containsKey(key)) {
      return _EditDeliveryDetailViewTextEditingControllers[key]!;
    }

    _EditDeliveryDetailViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _EditDeliveryDetailViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_EditDeliveryDetailViewFocusNodes.containsKey(key)) {
      return _EditDeliveryDetailViewFocusNodes[key]!;
    }
    _EditDeliveryDetailViewFocusNodes[key] = FocusNode();
    return _EditDeliveryDetailViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    addressController.addListener(() => _updateFormData(model));
    apartmentController.addListener(() => _updateFormData(model));
    countryController.addListener(() => _updateFormData(model));
    stateController.addListener(() => _updateFormData(model));
    phoneController.addListener(() => _updateFormData(model));
    nameController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    addressController.addListener(() => _updateFormData(model));
    apartmentController.addListener(() => _updateFormData(model));
    countryController.addListener(() => _updateFormData(model));
    stateController.addListener(() => _updateFormData(model));
    phoneController.addListener(() => _updateFormData(model));
    nameController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          AddressValueKey: addressController.text,
          ApartmentValueKey: apartmentController.text,
          CountryValueKey: countryController.text,
          StateValueKey: stateController.text,
          PhoneValueKey: phoneController.text,
          NameValueKey: nameController.text,
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

    for (var controller
        in _EditDeliveryDetailViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _EditDeliveryDetailViewFocusNodes.values) {
      focusNode.dispose();
    }

    _EditDeliveryDetailViewTextEditingControllers.clear();
    _EditDeliveryDetailViewFocusNodes.clear();
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

  String? get addressValue => this.formValueMap[AddressValueKey] as String?;
  String? get apartmentValue => this.formValueMap[ApartmentValueKey] as String?;
  String? get countryValue => this.formValueMap[CountryValueKey] as String?;
  String? get stateValue => this.formValueMap[StateValueKey] as String?;
  String? get phoneValue => this.formValueMap[PhoneValueKey] as String?;
  String? get nameValue => this.formValueMap[NameValueKey] as String?;

  set addressValue(String? value) {
    this.setData(
      this.formValueMap..addAll({AddressValueKey: value}),
    );

    if (_EditDeliveryDetailViewTextEditingControllers.containsKey(
        AddressValueKey)) {
      _EditDeliveryDetailViewTextEditingControllers[AddressValueKey]?.text =
          value ?? '';
    }
  }

  set apartmentValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ApartmentValueKey: value}),
    );

    if (_EditDeliveryDetailViewTextEditingControllers.containsKey(
        ApartmentValueKey)) {
      _EditDeliveryDetailViewTextEditingControllers[ApartmentValueKey]?.text =
          value ?? '';
    }
  }

  set countryValue(String? value) {
    this.setData(
      this.formValueMap..addAll({CountryValueKey: value}),
    );

    if (_EditDeliveryDetailViewTextEditingControllers.containsKey(
        CountryValueKey)) {
      _EditDeliveryDetailViewTextEditingControllers[CountryValueKey]?.text =
          value ?? '';
    }
  }

  set stateValue(String? value) {
    this.setData(
      this.formValueMap..addAll({StateValueKey: value}),
    );

    if (_EditDeliveryDetailViewTextEditingControllers.containsKey(
        StateValueKey)) {
      _EditDeliveryDetailViewTextEditingControllers[StateValueKey]?.text =
          value ?? '';
    }
  }

  set phoneValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PhoneValueKey: value}),
    );

    if (_EditDeliveryDetailViewTextEditingControllers.containsKey(
        PhoneValueKey)) {
      _EditDeliveryDetailViewTextEditingControllers[PhoneValueKey]?.text =
          value ?? '';
    }
  }

  set nameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({NameValueKey: value}),
    );

    if (_EditDeliveryDetailViewTextEditingControllers.containsKey(
        NameValueKey)) {
      _EditDeliveryDetailViewTextEditingControllers[NameValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasAddress =>
      this.formValueMap.containsKey(AddressValueKey) &&
      (addressValue?.isNotEmpty ?? false);
  bool get hasApartment =>
      this.formValueMap.containsKey(ApartmentValueKey) &&
      (apartmentValue?.isNotEmpty ?? false);
  bool get hasCountry =>
      this.formValueMap.containsKey(CountryValueKey) &&
      (countryValue?.isNotEmpty ?? false);
  bool get hasState =>
      this.formValueMap.containsKey(StateValueKey) &&
      (stateValue?.isNotEmpty ?? false);
  bool get hasPhone =>
      this.formValueMap.containsKey(PhoneValueKey) &&
      (phoneValue?.isNotEmpty ?? false);
  bool get hasName =>
      this.formValueMap.containsKey(NameValueKey) &&
      (nameValue?.isNotEmpty ?? false);

  bool get hasAddressValidationMessage =>
      this.fieldsValidationMessages[AddressValueKey]?.isNotEmpty ?? false;
  bool get hasApartmentValidationMessage =>
      this.fieldsValidationMessages[ApartmentValueKey]?.isNotEmpty ?? false;
  bool get hasCountryValidationMessage =>
      this.fieldsValidationMessages[CountryValueKey]?.isNotEmpty ?? false;
  bool get hasStateValidationMessage =>
      this.fieldsValidationMessages[StateValueKey]?.isNotEmpty ?? false;
  bool get hasPhoneValidationMessage =>
      this.fieldsValidationMessages[PhoneValueKey]?.isNotEmpty ?? false;
  bool get hasNameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey]?.isNotEmpty ?? false;

  String? get addressValidationMessage =>
      this.fieldsValidationMessages[AddressValueKey];
  String? get apartmentValidationMessage =>
      this.fieldsValidationMessages[ApartmentValueKey];
  String? get countryValidationMessage =>
      this.fieldsValidationMessages[CountryValueKey];
  String? get stateValidationMessage =>
      this.fieldsValidationMessages[StateValueKey];
  String? get phoneValidationMessage =>
      this.fieldsValidationMessages[PhoneValueKey];
  String? get nameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey];
}

extension Methods on FormStateHelper {
  setAddressValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AddressValueKey] = validationMessage;
  setApartmentValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ApartmentValueKey] = validationMessage;
  setCountryValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CountryValueKey] = validationMessage;
  setStateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[StateValueKey] = validationMessage;
  setPhoneValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PhoneValueKey] = validationMessage;
  setNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NameValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    addressValue = '';
    apartmentValue = '';
    countryValue = '';
    stateValue = '';
    phoneValue = '';
    nameValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      AddressValueKey: getValidationMessage(AddressValueKey),
      ApartmentValueKey: getValidationMessage(ApartmentValueKey),
      CountryValueKey: getValidationMessage(CountryValueKey),
      StateValueKey: getValidationMessage(StateValueKey),
      PhoneValueKey: getValidationMessage(PhoneValueKey),
      NameValueKey: getValidationMessage(NameValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _EditDeliveryDetailViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _EditDeliveryDetailViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      AddressValueKey: getValidationMessage(AddressValueKey),
      ApartmentValueKey: getValidationMessage(ApartmentValueKey),
      CountryValueKey: getValidationMessage(CountryValueKey),
      StateValueKey: getValidationMessage(StateValueKey),
      PhoneValueKey: getValidationMessage(PhoneValueKey),
      NameValueKey: getValidationMessage(NameValueKey),
    });
