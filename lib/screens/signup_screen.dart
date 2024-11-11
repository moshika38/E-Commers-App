import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/main_screen.dart';
import 'package:flutter_application_1/widgets/social_button.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../functions/form_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isAgree = true;
  bool isEmailErr = false;
  bool isPasswordErr = false;
  bool isConfirmPasswordErr = false;
  bool isLoading = false;
  String errorMessage = "";

  

  // form validation function
  void checkError() async {
    final result = FormValidator.validateSignUpForm(
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      isAgree: isAgree,
    );
    setState(() {
      errorMessage = result.message;
      isEmailErr = result.isEmailError;
      isPasswordErr = result.isPasswordError;
      isConfirmPasswordErr = result.isConfirmPasswordError;
    });

     

    // email password login
    if (!result.isEmailError &&
        !result.isPasswordError &&
        !result.isConfirmPasswordError &&
        isAgree) {
      // TODO: Implement signup logic
      isLoading = true;

      setState(() {});
      try {
        final navigator = Navigator.of(context);
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        isLoading = false;
        setState(() {});
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
 
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully! Please login.'),
            backgroundColor: AppColors.primary,
          ),
        );
        if (mounted) {
          navigator.pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      } catch (e) {
        isLoading = false;
        setState(() {});

        if (e.toString().contains('email-already-in-use')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'This email is already registered. Please use a different email.'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('An error occurred during sign up. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  // google authentication function

  Future<void> signInWithGoogle() async {
    try {
      isLoading = true;
      setState(() {});
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        isLoading = false;
        setState(() {});
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final navigator = Navigator.of(context);
      await FirebaseAuth.instance.signInWithCredential(credential);
      isLoading = false;
      setState(() {});

      if (mounted) {
        navigator.pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    } catch (e) {
      isLoading = false;
      setState(() {});

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Google sign in failed. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Create an account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.headingText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please fill in the details below',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.secondaryText,
                    ),
                  ),
                  SizedBox(
                    height: errorMessage.isEmpty ? 30 : 50,
                    child: Center(
                      child: Text(
                        errorMessage.isNotEmpty ? "* $errorMessage" : "",
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ),
                  CustomTextField(
                    isError: isEmailErr,
                    controller: emailController,
                    label: 'Email',
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    isError: isPasswordErr,
                    controller: passwordController,
                    label: 'Password',
                    hintText: '••••••••',
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    isError: isConfirmPasswordErr,
                    controller: confirmPasswordController,
                    label: 'Confirm Password',
                    hintText: '••••••••',
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      SizedBox(
                        height: 24,
                        child: Checkbox(
                          value: isAgree,
                          onChanged: (value) {
                            setState(() {
                              isAgree = value ?? false;
                            });
                          },
                          activeColor: AppColors.primary,
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'I agree to the Terms of Service and Privacy Policy',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.bodyText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Sign up',
                    isLoading: isLoading,
                    onPressed: () {
                      if (!isLoading) {
                        checkError();
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialLoginButton(
                        onPressed: () {
                          // TODO: Implement Google signup
                          if (!isLoading) {
                            signInWithGoogle();
                          }
                        },
                        iconPath: 'assets/icons/google.png',
                        label: 'Google',
                      ),
                      const SizedBox(width: 16),
                      SocialLoginButton(
                        onPressed: () {
                          // TODO: Implement Facebook signup
                        },
                        iconPath: 'assets/icons/facebook.png',
                        label: 'Facebook',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.bodyText,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
