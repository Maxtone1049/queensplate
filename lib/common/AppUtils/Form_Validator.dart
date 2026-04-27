import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_field/phone_number.dart';


class FieldValidator {
  static String? Function(String?) validateAlphaNumeric({String? error}) {
    return (String? value) {
      if (value!.isEmpty) {
        return error ?? 'Name is required.';
      }
      final RegExp nameExp = RegExp(r'^\w+$');
      if (!nameExp.hasMatch(value)) {
        return error ?? 'Please enter only alphanumeric characters.';
      }
      return null;
    };
  }

  static String? Function(String?) validateAlpha({String? error}) {
    return (String? value) {
      if (value!.isEmpty) {
        return error ?? 'Name is required.';
      }
      final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
      if (!nameExp.hasMatch(value)) {
        return error ?? 'Please enter only alphabetical characters.';
      }
      return null;
    };
  }

  static String? Function(String?) validateDouble({String? error}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return error ?? 'Field is required.';
      }
      if ((double.tryParse(value) ?? 0.0) <= 0.0) {
        return error ?? 'Not a valid number.';
      }
      return null;
    };
  }

  static String? Function(String?) validateNum({String? error}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return error ?? 'Field is required.';
      }
      return null;
    };
  }

  static String? Function(String?) validateCreditCard({String? error}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return error ?? 'Field is required.';
      }
      if (value.length < 19) {
        return error ?? 'Invalid Credit Card Number';
      }
      return null;
    };
  }

  static String? Function(String?) validateSmartCard({
    String? error,
    int cardLength = 0,
  }) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return error ?? 'Field is required.';
      }
      if (value.length != cardLength) {
        return 'Invalid smart card number';
      }
      if (error != null) return error;

      return null;
    };
  }

  static String? Function(String?) validateMeterNumber({
    String? error,
    int cardLength = 0,
  }) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return error ?? 'Field is required.';
      }
      /*  if (value.length != cardLength) {
        return 'Invalid meter number';
      } */
      if (error != null) return error;

      return null;
    };
  }

  static String? Function(String?) validateInt({String? error, int? limit}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return error ?? 'Field is required.';
      }
      if ((int.tryParse(value) ?? 0.0) <= 0) {
        return error ?? 'Not a valid number.';
      }
      if (limit != null) {
        if (value.length < limit) {
          return error ?? 'Not a valid number';
        }
      }
      return null;
    };
  }

  static String? Function(String?) validateEmail({String? error}) {
    return (String? value) {
      if (value!.isEmpty) {
        return error ?? 'Enter a valid email address';
      }
      if (!value.contains('@')) {
        return error ?? 'Not a valid email.';
      }
      if (value.contains(' ')) {
        return error ?? 'Spaces are not allowed';
      }
      if (error != null) return error;

      /*   if (!value.contains('@gmail.com') &&
          !value.contains('@yahoo.com') &&
          !value.contains('@hotmail.com')) {
        return error ?? 'Invalid email addresses not allowed';
      } */
      return null;
    };
  }

  static String? Function(String?) validatePhone({String? error}) {
    return (String? value) {
      if (value!.isEmpty) {
        return error ?? 'Enter a valid phone number';
      }
      if (!RegExp(r'^\d+?$').hasMatch(value) ||
          !value.startsWith(RegExp("0[1789]")) ||
          // Land lines eg 01
          (value.startsWith("01") && value.length != 9) ||
          // Land lines eg 080
          (value.startsWith(RegExp("0[789]")) && value.length != 11)) {
        return error ?? 'Not a valid phone number.';
      }
      return null;
    };
  }

  static FutureOr<String?> Function(PhoneNumber?)? validateIntlPhoneNumber({
    String? error,
  }) {
    return (PhoneNumber? value) {
      if (value!.number.isEmpty) {
        return error ?? 'Enter a valid phone number';
      }
      return null;
    };
  }

  static String? Function(String?) validateString({
    String? error,
    int? min,
    int? max,
  }) {
    return (String? value) {
      if (value == null || value.isEmpty || value.trim().isEmpty) {
        return error ?? 'Field is required.';
      }
      if (error != null && error.isNotEmpty) {
        return error;
      }
      if ((min != null) && (value.length < min)) {
        return error ?? 'Minimum length should be $min';
      }
      if ((max != null) && (value.length > max)) {
        return error ?? 'Maximum length should be $max';
      }
      return null;
    };
  }


  static String? Function(String?) validateOTP({String? error}) {
    return (String? value) {
      if (value == null || value.isEmpty || value.trim().isEmpty) {
        return error ?? 'Field is required.';
      }
      if (value.length < 4) {
        return 'Invalid Code';
      }
      if (error != null) return error;
      return null;
    };
  }

  static String? Function(String?) validatePass({String? error}) {
    return (String? value) {
      if (value == null || value.isEmpty || value.trim().isEmpty) {
        return error;
      }

      // else if (value.length < 6 || value.length > 255) {
      //   return 'Password must be 6-255 characters';
      // }
      //  else if (!_hasSpecialCharacter(value)) {
      //   return 'Password must contain at least one special character';
      // }
      return null;
    };
  }

  static String? Function(String?) validateName({String? error}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Fullname is required';
      }
      return null;
    };
  }

  static String? Function(String?) validatePlainPass({String? error}) {
    return (String? value) {
      if (value == null || value.isEmpty || value.trim().isEmpty) {
        return 'Password is required';
      } else if (value.length < 8 || value.length > 255) {
        return 'Password must be a minimum 8 characters';
      }
      return null;
    };
  }

  static String? Function(File) validateFile({String? error}) {
    return (File file) {
      if (file.path.isEmpty) {
        return error ?? 'Invalid File.';
      }
      return null;
    };
  }

  static String? Function(String?) checkAmount({String? error}) {
    return (String? value) {
      if (value == null || value.isEmpty) return 'Please enter an Amount.';
      return null;
    };
  }

  static String? Function(String?) validateAmount({
    String? error,
    double? minAmount = 5000,
    double? maxAmount = 10000000,
  }) {
    return (String? value) {
      value = value?.replaceAll(",", "");

      if (value?.isEmpty ?? false) {
        return error ?? 'Amount is required.';
      }
      if (double.tryParse(value ?? '0') == null) {
        return error ?? 'Invalid Amount.';
      }
      if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value ?? '0')) {
        return error ?? 'Not a valid amount.';
      }
      if (double.tryParse(value ?? '0')! <= 0.0) {
        return error ?? 'Zero Amount is not allowed.';
      }
      if (double.tryParse(value ?? '0')! < minAmount!) {
        return error ?? 'Minimum amount allow is $minAmount';
      }
      if (double.tryParse(value ?? '0')! > maxAmount!) {
        return 'Maximum amount allow is $maxAmount';
      }
      return null;
    };
  }

  static String? Function(String?) validateCryptoAmount({
    String? error,
    double? minAmount = 10,
    double? maxAmount = 10000000000,
  }) {
    return (String? value) {
      value = value?.replaceAll(",", "");

      if (value?.isEmpty ?? false) {
        return error ?? 'Amount is required.';
      }
      if (double.tryParse(value ?? '0') == null) {
        return error ?? 'Invalid Amount.';
      }
      if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value ?? '0')) {
        return error ?? 'Not a valid amount.';
      }
      if (double.tryParse(value ?? '0')! <= 0.0) {
        return error ?? 'Zero Amount is not allowed.';
      }
      if (double.tryParse(value ?? '0')! < minAmount!) {
        return error ?? 'Minimum amount allowed is $minAmount';
      }
      if (double.tryParse(value ?? '0')! > maxAmount!) {
        return 'Maximum amount allowed is $maxAmount';
      }
      return null;
    };
  }

  static String? Function(String?) validateDiffChange(
    TextEditingController field, [
    String? error,
  ]) {
    return (String? value) {
      if (field.text != value) return error ?? 'Passwords don\'t match';

      return null;
    };
  }

  static String? Function(String?) validatePassword(
    TextEditingController passwordController, {
    String? error,
  }) {
    return (String? value) {
      if (value == null || value.isEmpty) return 'Please enter a password.';

      return validateDiffChange(
        passwordController,
        error ?? 'The passwords don\'t match',
      )(value);
    };
  }

  static String? Function(String?) validateNameTag({String? error}) {
    return (String? value) {
      if (value == null || value.isEmpty) return 'Please enter a Name Tag.';
      return null;

      // return;
    };
  }
}
