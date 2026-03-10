/// Form validators for TaskFlow (email, password, required, etc.)
class Validators {
  Validators._();

  static const int minPasswordLength = 6;

  /// Returns error message if invalid, null if valid.
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty)
      return null; // use required separately
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value.trim())) return 'wrongEmailValidation';
    return null;
  }

  /// Returns error message key if invalid, null if valid.
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) return 'requiredField';
    return null;
  }

  /// Returns error message key if invalid, null if valid.
  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'requiredPassword';
    if (value.length < minPasswordLength) return 'smallPassword';
    return null;
  }

  /// Confirm password must match [passwordValue].
  static String? confirmPassword(String? value, String passwordValue) {
    if (value == null || value.isEmpty) return 'requiredPassword';
    if (value != passwordValue) return 'passwordNotMatch';
    return null;
  }

  /// Required for task title / name fields.
  static String? requiredTaskTitle(String? value) {
    if (value == null || value.trim().isEmpty) return 'requiredField';
    return null;
  }
}
