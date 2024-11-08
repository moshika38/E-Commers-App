
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/app_colors.dart';
 
class SocialLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath;
  final String label;

  const SocialLoginButton({
    super.key, 
    required this.onPressed,
    required this.iconPath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.bodyText,
            ),
          ),
        ],
      ),
    );
  }
}
