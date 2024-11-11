import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main_screen.dart';
import 'package:flutter_application_1/services/user_services.dart';
import 'package:flutter_application_1/utils/app_colors.dart';

class CartItem extends StatefulWidget {
  final String image;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final int index;
  final Function(int) onQuantityChanged;

  const CartItem({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.index,
    required this.onQuantityChanged,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int _quantity;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  void _decrementQuantity() async {
    if (_quantity > 0) {
      final newQuantity = _quantity - 1;

      if (newQuantity == 0) {
        setState(() {
          _isDeleting = true;
        });

        // Remove item first
        await UserServices().removeCartItem(
          FirebaseAuth.instance.currentUser!.uid,
          widget.index,
        );

        if (mounted) {
          // Check if widget is still mounted
          setState(() {
            _quantity = 0;
            _isDeleting = false;
          });
          widget.onQuantityChanged(0);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item removed from cart'),
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(loadScreen: 1),
            ),
          );
        }
      } else {
        setState(() {
          _quantity = newQuantity;
        });
        UserServices().updateCartItemQty(
          FirebaseAuth.instance.currentUser!.uid,
          widget.index,
          _quantity,
        );
        widget.onQuantityChanged(_quantity);
      }
    }
  }

  void _incrementQuantity() {
    if (_quantity < 9) {
      setState(() {
        _quantity++;
      });
      UserServices().updateCartItemQty(
        FirebaseAuth.instance.currentUser!.uid,
        widget.index,
        _quantity,
      );
      widget.onQuantityChanged(_quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  widget.image,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 40,
                      height: 40,
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
                      widget.description.length > 25
                          ? '${widget.description.substring(0, 25)}...'
                          : widget.description,
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
        ),
        if (_isDeleting)
          Container(
            color: Colors.white.withOpacity(0.7),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
