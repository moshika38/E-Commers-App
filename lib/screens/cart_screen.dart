import 'package:flutter/material.dart';
import 'package:login_app/utils/app_colors.dart';
import 'package:login_app/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shopping Cart',
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.headingText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '(3 items)',
                    style: TextStyle(
                      color: AppColors.bodyText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: const Column(
                      children: [
                        CartItem(
                          image: 'assets/icons/coffee-logo.png',
                          name: 'Cappuccino',
                          description: 'With Oat Milk',
                          price: 4.99,
                          quantity: 1,
                        ),
                        Divider(),
                        CartItem(
                          image: 'assets/icons/coffee-logo.png',
                          name: 'Latte',
                          description: 'With Almond Milk',
                          price: 5.99,
                          quantity: 2,
                        ),
                         
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SummaryRow(label: 'Subtotal', value: 15.97),
                    const SummaryRow(label: 'Shipping', value: 2.00),
                    const SummaryRow(label: 'Tax', value: 1.44),
                    const Divider(),
                    const SummaryRow(
                      label: 'Total',
                      value: 19.41,
                      isTotal: true,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Proceed to Checkout',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isTotal;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 20 : 16,
              color: isTotal ? AppColors.headingText : AppColors.bodyText,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 20 : 16,
              color: isTotal ? AppColors.headingText : AppColors.bodyText,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
