import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/app_colors.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Help Center',
          style: TextStyle(
            color: AppColors.background,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.background),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                color: AppColors.headingText,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            _buildFaqItem(
              'How do I place an order?',
              'Select your items, add them to cart, and proceed to checkout. Follow the prompts to complete your purchase.',
            ),
            _buildFaqItem(
              'What payment methods are accepted?',
              'We accept credit/debit cards and other major payment methods.',
            ),
            _buildFaqItem(
              'How can I track my order?',
              'You can track your order in the Orders section of your profile.',
            ),
            _buildFaqItem(
              'What is your return policy?',
              'Items can be returned within 30 days of delivery. They must be unused and in original packaging.',
            ),
            
            _buildFaqItem(
              'How long does shipping take?',
              'Domestic orders typically arrive in 3-5 business days. International shipping can take 7-14 business days.',
            ),
            const SizedBox(height: 30),
            const Text(
              'Contact Support',
              style: TextStyle(
                color: AppColors.headingText,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email: support@example.com',
                    style: TextStyle(
                      color: AppColors.bodyText,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Phone: +1 234 567 8900',
                    style: TextStyle(
                      color: AppColors.bodyText,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Hours: Monday - Friday, 9AM - 6PM EST',
                    style: TextStyle(
                      color: AppColors.bodyText,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Address: 123 Support Street, Help City, HC 12345',
                    style: TextStyle(
                      color: AppColors.bodyText,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            color: AppColors.bodyText,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
