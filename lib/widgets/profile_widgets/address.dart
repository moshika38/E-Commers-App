import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/user_services.dart';
import 'package:flutter_application_1/utils/app_colors.dart';

class AddressWindow {
  final BuildContext context;

  AddressWindow({
    required this.context,
  });

  void showWindow() async {
    TextEditingController streetAddress = TextEditingController();
    TextEditingController city = TextEditingController();
    TextEditingController state = TextEditingController();
    TextEditingController postalCode = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
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
                'Shipping Address',
                style: TextStyle(
                  color: AppColors.headingText,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 25),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: streetAddress,
                      decoration: InputDecoration(
                        labelText: 'Street Address',
                        prefixIcon: const Icon(Icons.location_on,
                            color: AppColors.primary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: city,
                      decoration: InputDecoration(
                        labelText: 'City',
                        prefixIcon: const Icon(Icons.location_city,
                            color: AppColors.primary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: state,
                      decoration: InputDecoration(
                        labelText: 'State/Province',
                        prefixIcon:
                            const Icon(Icons.map, color: AppColors.primary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: postalCode,
                      decoration: InputDecoration(
                        labelText: 'Postal Code',
                        prefixIcon: const Icon(Icons.local_post_office,
                            color: AppColors.primary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
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
                            // Handle save address logic here
                            if (streetAddress.text.isEmpty ||
                                city.text.isEmpty ||
                                state.text.isEmpty ||
                                postalCode.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Please fill in all address fields'),
                                  backgroundColor: AppColors.error,
                                ),
                              );
                              Navigator.pop(context);
                            } else {
                              // Get current user ID
                              String userId =
                                  FirebaseAuth.instance.currentUser!.uid;

                              // Create address map
                              Map<String, dynamic> addressFields = {
                                'address': {
                                  'street': streetAddress.text,
                                  'city': city.text,
                                  'state': state.text,
                                  'postalCode': postalCode.text
                                }
                              };

                              // Update user document
                              UserServices()
                                  .updateUserFields(userId, addressFields);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Address saved successfully'),
                                  backgroundColor: AppColors.primary,
                                ),
                              );
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Save Address',
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
      ),
    );
  }
}
