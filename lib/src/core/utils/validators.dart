import 'package:email_validator/email_validator.dart';

abstract final class Validator {
  static const String _fillThisField = 'Please fill this field.';

  static bool _isEmpty(String? value) => value == null || value.isEmpty;

  static String? valueExists(String? value) {
    if (_isEmpty(value)) {
      return _fillThisField;
    }
    return null;
  }

  static String? nameValidate(String? value) {
    if (_isEmpty(value)) {
      return _fillThisField;
    }

    if (value!.length < 3) {
      return 'Name must be at least 3 characters.';
    } else if (value.length > 20) {
      return 'Name is too long. Please reduce it.';
    }
    return null;
  }

  static String? phoneValidate(String? value) {
    if (_isEmpty(value)) {
      return _fillThisField;
    }

    final regExp = RegExp(r'^[0-9]{9,13}$');
    final isValidPhone = regExp.hasMatch(value!);

    if (!isValidPhone) {
      return 'Invalid phone number!';
    }

    return null;
  }

  static String? passwordValidate(String? value) {
    if (_isEmpty(value)) {
      return _fillThisField;
    }

    if (value!.length < 8) {
      return 'Your password must be at least 8 characters.';
    }
    return null;
  }

  static String? confirmPasswordValidate(String? value, String password) {
    if (value != password) {
      return 'Password does not match.';
    }
    return null;
  }

  static String? otpValidate(String? value) {
    if (_isEmpty(value)) {
      return _fillThisField;
    }
    if (value!.length != 6) {
      return 'Invalid OTP code.';
    }
    return null;
  }

  static String? emailValidate(String? value) {
    if (_isEmpty(value)) {
      return _fillThisField;
    }

    if (!EmailValidator.validate(value!)) {
      return 'Invalid Email Address.';
    }
    return null;
  }
}
