import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/screens/cart_screen.dart';
import 'package:flutter_application_1/screens/explore_screen.dart';
import 'package:flutter_application_1/screens/favorites_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:flutter_application_1/services/user_services.dart';

import '../utils/app_colors.dart';

class MainScreen extends StatefulWidget {
  final int? loadScreen;
  const MainScreen({
    super.key,
    this.loadScreen,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 2;
  UserModel? userModel;
  User? user;
  void createUserProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      user = currentUser;
      setState(() {});
      try {
        final userDoc = await UserServices().getSingleUser(user!.uid);
        if (userDoc == null) {
          // Create new user profile for first-time users
          final newUser = UserModel(
            displayName: user!.displayName ?? "Guest",
            id: user!.uid,
            photoURL: user!.photoURL ?? "",
          );
          await UserServices().addUser(newUser);
          setState(() {
            userModel = newUser;
          });
        } else {
          // For existing users, update their details if they've changed
          final existingUser =
              UserModel.fromMap(userDoc as Map<String, dynamic>);
          if (existingUser.displayName != user!.displayName ||
              existingUser.photoURL != user!.photoURL) {
            final updatedUser = UserModel(
              displayName: user!.displayName ?? existingUser.displayName,
              id: user!.uid,
              photoURL: user!.photoURL ?? existingUser.photoURL,
            );
            await UserServices().addUser(updatedUser);
            setState(() {
              userModel = updatedUser;
            });
          } else {
            // No changes needed, just load existing data
            setState(() {
              userModel = existingUser;
            });
          }
        }
      } catch (e) {
        print('Error creating/fetching user profile: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    createUserProfile();

    if (widget.loadScreen != null) {
      setState(() {
        currentIndex = widget.loadScreen ?? 2;
      });
    }
  }

  List<Widget> screens = [
    const ExploreScreen(),
    const CartScreen(),
    const HomeScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
