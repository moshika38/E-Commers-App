import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/item_data.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/screens/item_screen.dart';
import 'package:flutter_application_1/screens/main_screen.dart';
import 'package:flutter_application_1/screens/notification_sereen.dart';
import 'package:flutter_application_1/services/user_services.dart';
import 'package:flutter_application_1/widgets/banner.dart';
import 'package:flutter_application_1/widgets/category_item.dart';
import 'package:flutter_application_1/widgets/product_cart.dart';
import 'package:flutter_application_1/widgets/search_bar.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ItemData itemData = ItemData();
  UserModel? userModel;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (user != null) {
      userModel = await UserServices().getSingleUser(user!.uid);
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: userModel?.photoURL != null &&
                                userModel!.photoURL!.isNotEmpty
                            ? CircleAvatar(
                                backgroundImage:
                                    NetworkImage(userModel!.photoURL!),
                              )
                            : Lottie.asset(
                                'assets/animations/user.json',
                                fit: BoxFit.cover,
                              ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good morning,',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            (userModel?.displayName?.isEmpty ?? true)
                                ? 'Guest'
                                : ((userModel!.displayName!.length > 11)
                                    ? '${userModel!.displayName!.substring(0, 11)}...'
                                    : userModel!.displayName!),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Search Bar
              const AppSearchBar(),
              const SizedBox(height: 24),

              // Promo Card
              const AppBanner(),

              // Categories Section
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(loadScreen: 0),
                        ),
                      );
                    },
                    child: const Text('See All'),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(
                              loadScreen: 0,
                              select: 'Coffee',
                            ),
                          ),
                        );
                      },
                      child: const CategoryItem(icon: Icons.coffee, label: 'Coffee'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(
                              loadScreen: 0,
                              select: 'Tea',
                            ),
                          ),
                        );
                      },
                      child: const CategoryItem(icon: Icons.local_cafe, label: 'Tea'),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(
                                loadScreen: 0,
                                select: 'Pastries',
                              ),
                            ),
                          );
                        },
                        child: const CategoryItem(
                            icon: Icons.cookie, label: 'Pastries')),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(
                                loadScreen: 0,
                                select: 'Desserts',
                              ),
                            ),
                          );
                        },
                        child: const CategoryItem(
                            icon: Icons.icecream, label: 'Desserts')),
                  ],
                ),
              ),

              // Products Grid
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Now',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(loadScreen: 0),
                        ),
                      );
                    },
                    child: const Text('See All'),
                  ),
                ],
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: itemData.itemDataList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemScreen(
                            index: index.toString(),
                            itemName: itemData.itemDataList[index].name,
                            price: itemData.itemDataList[index].price,
                            description:
                                itemData.itemDataList[index].description,
                            imageUrl: itemData.itemDataList[index].imageUrl,
                          ),
                        ),
                      );
                    },
                    child: ProductCard(
                      uid: user!.uid,
                      index: index,
                      name: itemData.itemDataList[index].name,
                      description: itemData.itemDataList[index].description,
                      price: itemData.itemDataList[index].price,
                      imageUrl: itemData.itemDataList[index].imageUrl,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
