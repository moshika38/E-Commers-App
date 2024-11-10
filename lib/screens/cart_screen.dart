import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/item_data.dart';
import 'package:flutter_application_1/services/user_services.dart';
import 'package:flutter_application_1/utils/app_colors.dart';
import 'package:flutter_application_1/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<String> cartItemIndex = [];
  final ItemData itemData = ItemData();
  Map<String, int> quantities = {};

  @override
  void initState() {
    super.initState();
    getUserCart();
  }

  void getUserCart() async {
    try {
      final cartModel = await UserServices().getUserCart(
        FirebaseAuth.instance.currentUser!.uid,
      );
      
      setState(() {
        cartItemIndex = cartModel?.cartItem ?? [];
        for (var item in cartItemIndex) {
          quantities[item] = 1;
        }
      });
      debugPrint('Cart items: $cartItemIndex');
    } catch (e) {
      debugPrint('Error fetching cart: $e');
    }
  }

  double calculateSubtotal() {
    double subtotal = 0;
    for (var index in cartItemIndex) {
      subtotal += itemData.itemDataList[int.parse(index)].price *
          (quantities[index] ?? 1);
    }
    return subtotal;
  }

  void updateQuantity(String itemIndex, int newQuantity) {
    setState(() {
      quantities[itemIndex] = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Shopping Cart',
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.headingText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '(${cartItemIndex.length} items)',
                    style: const TextStyle(
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
                    child: GridView.builder(
                      itemCount: cartItemIndex.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 2,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CartItem(
                              name: itemData
                                  .itemDataList[int.parse(cartItemIndex[index])]
                                  .name,
                              image: itemData
                                  .itemDataList[int.parse(cartItemIndex[index])]
                                  .imageUrl,
                              description: itemData
                                  .itemDataList[int.parse(cartItemIndex[index])]
                                  .description,
                              price: itemData
                                  .itemDataList[int.parse(cartItemIndex[index])]
                                  .price,
                              quantity: quantities[cartItemIndex[index]] ?? 1,
                              onQuantityChanged: (newQuantity) =>
                                  updateQuantity(
                                      cartItemIndex[index], newQuantity),
                            ),
                            Divider(),
                          ],
                        );
                      },
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
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SummaryRow(label: 'Subtotal', value: calculateSubtotal()),
                    const SummaryRow(label: 'Shipping', value: 2.00),
                    SummaryRow(label: 'Tax', value: calculateSubtotal() * 0.09),
                    const Divider(),
                    SummaryRow(
                      label: 'Total',
                      value: calculateSubtotal() +
                          2.00 +
                          (calculateSubtotal() * 0.09),
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
