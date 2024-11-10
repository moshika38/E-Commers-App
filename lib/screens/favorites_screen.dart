import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/item_data.dart';
import 'package:flutter_application_1/services/user_services.dart';
import 'package:flutter_application_1/widgets/fav_product_card.dart';
import '../utils/app_colors.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<String> favItemIndex = [];
  final ItemData itemData = ItemData();

  void getFavItems() async {
    final items = await UserServices()
        .getUserFavorites(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      favItemIndex = items;
    });
  }

  @override
  void initState() {
    super.initState();
    getFavItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Favorite Items',
                      style: TextStyle(
                        color: AppColors.headingText,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '(${favItemIndex.length} items)',
                      style: TextStyle(
                        color: AppColors.bodyText,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: favItemIndex.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 64,
                              color: AppColors.bodyText.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No favorite items added yet',
                              style: TextStyle(
                                color: AppColors.bodyText.withOpacity(0.5),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: favItemIndex.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                          itemBuilder: (context, index) {
                            return FavProductCard(
                              uid: FirebaseAuth.instance.currentUser!.uid,
                              itemId: favItemIndex[index],
                              index: index,
                              name: itemData
                                  .itemDataList[int.parse(favItemIndex[index])]
                                  .name,
                              description: itemData
                                  .itemDataList[int.parse(favItemIndex[index])]
                                  .description,
                              price: itemData
                                  .itemDataList[int.parse(favItemIndex[index])]
                                  .price,
                              imageUrl: itemData
                                  .itemDataList[int.parse(favItemIndex[index])]
                                  .imageUrl,
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
