import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/payment_model.dart';
import 'package:flutter_application_1/screens/main_screen.dart';
import 'package:flutter_application_1/services/user_services.dart';
import 'package:flutter_application_1/utils/app_colors.dart';

class PaymentWindow {
  final BuildContext context;
  final PaymentModel? paymentDetails;

  PaymentWindow({
    required this.context,
    this.paymentDetails,
  });

  void showWindow() {
    TextEditingController cardNumber =
        TextEditingController(text: paymentDetails?.cardNumber ?? "");
    TextEditingController expiryDate =
        TextEditingController(text: paymentDetails?.expiryDate ?? "");
    TextEditingController cvv =
        TextEditingController(text: paymentDetails?.cvv ?? "");
    TextEditingController cardholderName =
        TextEditingController(text: paymentDetails?.holderName ?? "");

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          insetPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment Method',
                  style: TextStyle(
                    color: AppColors.headingText,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: cardNumber,
                        decoration: InputDecoration(
                          labelText: 'Card Number',
                          prefixIcon: const Icon(Icons.credit_card,
                              color: AppColors.primary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: expiryDate,
                              decoration: InputDecoration(
                                labelText: 'Expiry Date (MM/YY)',
                                prefixIcon: const Icon(Icons.calendar_today,
                                    color: AppColors.primary),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextField(
                              controller: cvv,
                              decoration: InputDecoration(
                                labelText: 'CVV',
                                prefixIcon: const Icon(Icons.security,
                                    color: AppColors.primary),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              maxLength: 3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: cardholderName,
                        decoration: InputDecoration(
                          labelText: 'Cardholder Name',
                          prefixIcon: const Icon(Icons.person,
                              color: AppColors.primary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: AppColors.bodyText),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              // Handle save payment method logic here
                              if (cardNumber.text.isEmpty ||
                                  expiryDate.text.isEmpty ||
                                  cvv.text.isEmpty ||
                                  cardholderName.text.isEmpty) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please fill in all fields'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else {
                                String userId =
                                    FirebaseAuth.instance.currentUser!.uid;
                                PaymentModel paymentData = PaymentModel(
                                  cardNumber: cardNumber.text,
                                  expiryDate: expiryDate.text,
                                  cvv: cvv.text,
                                  holderName: cardholderName.text,
                                  id: userId,
                                );
                                UserServices().addPayment(userId, paymentData);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Payment method saved'),
                                    backgroundColor: AppColors.primary,
                                  ),
                                );
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MainScreen(loadScreen: 4),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Save Card',
                              style: TextStyle(color: AppColors.background),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
