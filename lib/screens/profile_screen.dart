import 'package:flutter/material.dart';
import 'package:login_app/widgets/profile_widgets/address.dart';
import 'package:login_app/widgets/profile_widgets/logout.dart';
import 'package:login_app/widgets/profile_widgets/payment.dart';
import 'package:login_app/widgets/profile_widgets/user_details.dart';
import 'package:lottie/lottie.dart';
import '../utils/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: AppColors.headingText,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: Center(
                        child: Lottie.asset(
                          'assets/animations/user.json',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.background,
                            width: 2,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            // TODO: Implement ie picker functionality
                            UserDetails(
                              context: context,
                              nameController: TextEditingController(),
                              displayName: "Guest",
                            ).showWindow();
                          },
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Guest',
                  style: TextStyle(
                    color: AppColors.headingText,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  "email",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 40),
                _buildProfileOption(
                  icon: Icons.location_on_outlined,
                  title: 'Shipping Address',
                  onTap: () {
                    AddressWindow(context: context).showWindow();
                  },
                ),
                _buildProfileOption(
                  icon: Icons.payment_outlined,
                  title: 'Payment Method',
                  onTap: () {
                    PaymentWindow(context: context).showWindow();
                  },
                ),
                _buildProfileOption(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    LogoutWindow(context: context).showWindow();
                  },
                  showDivider: false,
                  textColor: AppColors.error,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool showDivider = true,
    Color? textColor,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: textColor ?? AppColors.primary),
          title: Text(
            title,
            style: TextStyle(
              color: textColor ?? AppColors.bodyText,
              fontSize: 16,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: textColor ?? AppColors.primary,
          ),
          onTap: onTap,
        ),
        if (showDivider)
          const Divider(
            color: AppColors.borderColor,
            height: 1,
          ),
      ],
    );
  }
}
