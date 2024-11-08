import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/app_colors.dart';

class CartItem extends StatefulWidget {
  final String image;
  final String name;
  final String description;
  final double price;
  final int quantity;

  const CartItem({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _incrementQuantity() {
    if (_quantity < 9) {
      setState(() {
        _quantity++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              widget.image,
              width: 40 ,
              height: 40 ,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 40 ,
                  height: 40 ,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                    size: 40,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.headingText,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${widget.price}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: _decrementQuantity,
                icon: const Icon(Icons.remove),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '$_quantity',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.bodyText,
                  ),
                ),
              ),
              IconButton(
                onPressed: _incrementQuantity,
                icon: const Icon(Icons.add),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
