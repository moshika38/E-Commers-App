class FormValidator {
  static ValidationResult validateSignUpForm({
    required String email,
    required String password,
    required String confirmPassword,
    required bool isAgree,
  }) {
    if (email.isEmpty && password.isEmpty && confirmPassword.isEmpty) {
      return ValidationResult(
        message: "Enter email, password and confirm password",
        isEmailError: true,
        isPasswordError: true,
        isConfirmPasswordError: true,
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
    } else if (confirmPassword.isEmpty) {
      return ValidationResult(
        message: "Enter confirm password",
        isConfirmPasswordError: true,
      );
    } else if (password != confirmPassword) {
      return ValidationResult(
        message: "Passwords do not match",
        isConfirmPasswordError: true,
      );
    } else if (!isAgree) {
      return ValidationResult(
        message: "Please agree to T&C",
      );
    }

    return ValidationResult();
  }
}

class ValidationResult {
  final String message;
  final bool isEmailError;
  final bool isPasswordError;
  final bool isConfirmPasswordError;

  ValidationResult({
    this.message = "",
    this.isEmailError = false,
    this.isPasswordError = false,
    this.isConfirmPasswordError = false,
  });
}
