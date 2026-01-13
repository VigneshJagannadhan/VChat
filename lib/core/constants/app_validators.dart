class AppValidators {
  /// GENERAL VALIDATOR
  static String? validateField(String? value) {
    if (value == null || value == "") return "This field can not be empty!";
    return null;
  }

  /// EMAIL VALIDATOR
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }

    final emailRegex = RegExp(r"^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$");
    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email address";
    }

    return null;
  }

  /// NAME VALIDATOR
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name cannot be empty";
    }

    final nameRegex = RegExp(r"^[a-zA-Z ]{2,}$");
    if (!nameRegex.hasMatch(value.trim())) {
      return "Enter a valid name";
    }

    return null;
  }

  /// PASSWORD VALIDATORS
  static String? validateRegistrationPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }

    final regex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );

    if (!regex.hasMatch(value)) {
      return "Password must contain uppercase, lowercase, number and special character";
    }

    return null;
  }

  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }

    return null;
  }
}
