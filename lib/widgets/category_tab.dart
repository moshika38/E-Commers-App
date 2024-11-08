import 'package:flutter/material.dart';
import 'package:login_app/utils/app_colors.dart';

class CategoryTab extends StatefulWidget {
  final String text;
  final bool isActive;
  final Function(String) onCategorySelected;

  const CategoryTab({
    super.key,
    required this.text,
    required this.isActive,
    required this.onCategorySelected,
  });

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: ElevatedButton(
        onPressed: () {
          widget.onCategorySelected(widget.text);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.isActive ? AppColors.primary : Colors.white,
          foregroundColor: widget.isActive ? Colors.white : AppColors.bodyText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color:
                  widget.isActive ? AppColors.primary : AppColors.borderColor,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: Text(widget.text),
      ),
    );
  }
}
