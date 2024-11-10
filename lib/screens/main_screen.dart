import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/cart_screen.dart';
import 'package:flutter_application_1/screens/explore_screen.dart';
import 'package:flutter_application_1/screens/favorites_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';

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

  @override
  void initState() {
    super.initState();
     
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
