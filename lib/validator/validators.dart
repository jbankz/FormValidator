import 'dart:io';

import 'package:flutter/widgets.dart';

/// A form validator handler class
class Validators {
  /// validates users input to alpha numeric
  static String Function(String) validateAlphaNumeric({String error}) {
    return (String value) {
      if (value.isEmpty) {
        return error ?? 'Field is required.';
      }
      final RegExp nameExp = RegExp(r'^\w+$');
      if (!nameExp.hasMatch(value)) {
        return error ?? 'Please enter only alphanumeric characters.';
      }
      return null;
    };
  }

  /// validates users input to alphabets
  static String Function(String) validateAlpha({String error}) {
    return (String value) {
      if (value.isEmpty) {
        return error ?? 'Field is required.';
      }
      final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
      if (!nameExp.hasMatch(value)) {
        return error ?? 'Please enter only alphabetical characters.';
      }
      return null;
    };
  }

  /// validates users input to double
  static String Function(String) validateDouble({String error}) {
    return (String value) {
      if (value == null || value.isEmpty) {
        return error ?? 'Field is required.';
      }
      if ((double.tryParse(value) ?? 0.0) <= 0.0) {
        return error ?? 'Not a valid number.';
      }
      return null;
    };
  }

  /// validates users input to int
  static String Function(String) validateInt({String error}) {
    return (String value) {
      if (value == null || value.isEmpty) {
        return error ?? 'Field is required.';
      }
      if ((int.tryParse(value) ?? 0.0) <= 0) {
        return error ?? 'Not a valid number.';
      }
      return null;
    };
  }

  /// validates users input to email address
  static String Function(String) validateEmail({String error}) {
    return (String value) {
      if (value.isEmpty) {
        return error ?? 'Enter a valid email address';
      }
      if (!value.contains('@')) {
        return error ?? 'Not a valid email.';
      }
      return null;
    };
  }

  /// validates users input to a valid phone number
  static String Function(String) validatePhone({String error}) {
    return (String value) {
      if (value.isEmpty) {
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

  /// validates users input to String type
  static String Function(String) validateString({String error}) {
    return (String value) {
      if (value == null || value.isEmpty || value.trim().isEmpty) {
        return error ?? 'Field is required.';
      }
      return null;
    };
  }

  /// validates users input to password ensuring the use
  /// of special characters
  static String Function(String) validatePasswordWithSpecialCharacters(
      {String error}) {
    return (String value) {
      if (value == null || value.isEmpty || value.trim().isEmpty) {
        return 'Password is required';
      } else if (value.length < 6 || value.length > 255) {
        return 'Password must be 6-255 characters';
      } else if (!_hasSpecialCharacter(value)) {
        return 'Password must contain at least one special character';
      }
      return null;
    };
  }

  /// validates users input to password
  /// without the use of special characters
  static String Function(String) validatePlainPassword({String error}) {
    return (String value) {
      if (value == null || value.isEmpty || value.trim().isEmpty) {
        return 'Password is required';
      } else if (value.length < 6 || value.length > 255) {
        return 'Password must be 6-255 characters';
      }
      return null;
    };
  }

  /// validates users input to a file
  static String Function(File) validateFile({String error}) {
    return (File file) {
      if (file == null || file.path.isEmpty) {
        return error ?? 'Invalid File.';
      }
      return null;
    };
  }

  /// validates users input to a valid amount type
  static String Function(String) validateAmount(
      {String error, double minAmount, double maxAmount}) {
    return (String value) {
      value = value.replaceAll(",", "");

      if (value.isEmpty) {
        return error ?? 'Amount is required.';
      }
      if (double.tryParse(value) == null) {
        return error ?? 'Invalid Amount.';
      }
      if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)) {
        return error ?? 'Not a valid amount.';
      }
      if (double.tryParse(value) <= 0.0) {
        return error ?? 'Zero Amount is not allowed.';
      }
      if (minAmount != null && double.tryParse(value) < minAmount) {
        return error ?? 'Minimum amount allow is $minAmount';
      }
      if (maxAmount != null && double.tryParse(value) > maxAmount) {
        return 'Maximum amount allow is $maxAmount';
      }
      return null;
    };
  }

  /// compares users input to that of a different
  /// field
  static String Function(String) validateDiffChange(
    FormFieldState<String> field, [
    String error,
  ]) {
    return (String value) {
      if (field?.value != value) {
        return error ?? 'Values don\'t match';
      }
      return null;
    };
  }

  /// ensures that the password used in the main field
  /// is equal to that used in the confirmed password field
  static String Function(String) validateMainPasswordWithConfirmPassword(
      FormFieldState<String> passwordField) {
    return (String value) {
      if (passwordField == null) {
        return 'Please enter a password.';
      }
      if (passwordField.value == null || passwordField.value.isEmpty) {
        return 'Please enter a password.';
      }
      return validateDiffChange(
        passwordField,
        'The passwords don\'t match',
      )(value);
    };
  }

  /// checks and returns a true or false value depending on
  /// if there is a special value or not
  static bool _hasSpecialCharacter(String value) {
    var specialChars = "<>@!#\$%^&*()_+[]{}?:;|'\"\\,./~`-=";
    for (int i = 0; i < specialChars.length; i++) {
      if (value.indexOf(specialChars[i]) > -1) {
        return true;
      }
    }
    return false;
  }
}
