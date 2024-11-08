import 'package:flutter/material.dart';
import 'package:login_app/utils/app_colors.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.focusShadow,
            blurRadius: 8,
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.search),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search coffee',
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.tune),
        ],
      ),
    );  
  }
}
