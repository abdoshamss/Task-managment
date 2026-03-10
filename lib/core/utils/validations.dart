import '../localization/localization_helper.dart';

class Validation {
  String? defaultValidation(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return (LocalizationHelper.tr.requiredField);
      }
      //short
      // if (value.length < (3)) //value.length < 3
      // {
      //   return ('shortField'.tr());
      // }
      return null;
    }
    return null;
  }

  static String? phoneValidation(String? value) {
    // String p =r'(^[+]?[(]?[0-9]{3}[)]?[-\s.]?[0-9]{3}[-\s.]?[0-9]{4,6}$)';
    String p = r'^5[0-9]{8}$';

    RegExp regExp = RegExp(p);
    if (value!.trim().isEmpty) {
      return (LocalizationHelper.tr.requiredPhone);
    } else if (!regExp.hasMatch(value.trim())) {
      return (LocalizationHelper.tr.phoneDoseNotMatch);
    } else {
      return null;
    }
  }

  static RegExp emailReg = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  String? emailValidation(String? value) {
    if (value!.trim().isEmpty) {
      return (LocalizationHelper.tr.requiredEmail);
    } else if (!emailReg.hasMatch(value.trim())) {
      return (LocalizationHelper.tr.wrongEmailValidation);
    } else {
      return null;
    }
  }

  String? passwordValidation(String? value) {
    if (value!.trim().isEmpty) {
      return (LocalizationHelper.tr.requiredPassword);
    } else if (value.trim().length < 8) {
      return (LocalizationHelper.tr.smallPassword);
    } else {
      return null;
    }
  }

  String? confirmPasswordValidation(value, String password) {
    if (value!.isEmpty) {
      return LocalizationHelper.tr.requiredField;
    } else if (password != value) {
      return (LocalizationHelper.tr.passwordNotMatch);
    } else {
      return null;
    }
  }

  static bool? isValidSaudiPhoneNumber(String input) {
    // Regular expression to match Saudi phone number format
    // Note: This is a simple example and may need adjustment based on actual requirements
    RegExp regex = RegExp(r'^5[0-9]{8}$');
    return regex.hasMatch(input);
  }
}
