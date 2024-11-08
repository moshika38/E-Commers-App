class LoginFormValidator {
  static ValidationResult validateSignUpForm({
    required String email,
    required String password,
  }) {
    if (email.isEmpty && password.isEmpty) {
      return ValidationResult(
        message: "Enter email and password",
        isEmailError: true,
        isPasswordError: true,
      );
    } else if (email.isEmpty) {
      return ValidationResult(
        message: "Enter email",
        isEmailError: true,
      );
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return ValidationResult(
        message: "Enter valid email",
        isEmailError: true,
      );
    } else if (password.isEmpty) {
      return ValidationResult(
        message: "Enter password",
        isPasswordError: true,
      );
    }

    return ValidationResult();
  }
}

class ValidationResult {
  final String message;
  final bool isEmailError;
  final bool isPasswordError;

  ValidationResult({
    this.message = "",
    this.isEmailError = false,
    this.isPasswordError = false,
  });
}
