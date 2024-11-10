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
  UserModel? userModel;
  User? user;

  // if user is new then create user data else get user data from firebase
  void createUserProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      user = currentUser;
      setState(() {});
      try {
        final userDoc = await UserServices().getSingleUser(user!.uid);
        if (userDoc == null) {
          // Only create new user if they don't exist in Firestore
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
          // User exists, just load their data
          setState(() {
            userModel = UserModel.fromMap(userDoc as Map<String, dynamic>);
          });
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
  }

  int currentIndex = 2;

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
