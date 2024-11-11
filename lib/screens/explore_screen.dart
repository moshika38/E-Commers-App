import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/item_data.dart';
import 'package:flutter_application_1/screens/item_screen.dart';
import 'package:flutter_application_1/widgets/category_tab.dart';
import 'package:flutter_application_1/widgets/coffee_card.dart';
import '../utils/app_colors.dart';

class ExploreScreen extends StatefulWidget {
  final String? select;
  const ExploreScreen({super.key, this.select});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String selectedCategory = 'All';

  final ItemData itemData = ItemData();

  @override
  void initState() {
    super.initState();
    if (widget.select != null) {
      setState(() {
        selectedCategory = widget.select.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Explore Coffee',
                          style: TextStyle(
                            color: AppColors.headingText,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                         
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: AppColors.bodyText),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search for coffee...',
                              hintStyle: TextStyle(color: AppColors.bodyText),
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                            ),
                            style: TextStyle(height: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CategoryTab(
                          text: 'All',
                          isActive: selectedCategory == 'All',
                          onCategorySelected: (category) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                        ),
                        CategoryTab(
                          text: 'Coffee',
                          isActive: selectedCategory == 'Coffee',
                          onCategorySelected: (category) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                        ),
                        CategoryTab(
                          text: 'Tea',
                          isActive: selectedCategory == 'Tea',
                          onCategorySelected: (category) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                        ),
                        CategoryTab(
                          text: 'Pastries',
                          isActive: selectedCategory == 'Pastries',
                          onCategorySelected: (category) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                        ),
                        CategoryTab(
                          text: 'Desserts',
                          isActive: selectedCategory == 'Desserts',
                          onCategorySelected: (category) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 315,
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: itemData.itemDataList
                            .where((item) =>
                                selectedCategory == 'All' ||
                                selectedCategory == item.type)
                            .length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 0.9,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          final filteredItems = itemData.itemDataList
                              .where((item) =>
                                  selectedCategory == 'All' ||
                                  selectedCategory == item.type)
                              .toList();
                          final item = filteredItems[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemScreen(
                                    description: item.description,
                                    imageUrl: item.imageUrl,
                                    itemName: item.name,
                                    price: item.price,
                                    index: index.toString(),
                                  ),
                                ),
                              );
                            },
                            child: CoffeeCard(
                              selectedCategory: selectedCategory,
                              index: index,
                              title: item.name,
                              description: item.description,
                              imagePath: item.imageUrl,
                              price: item.price,
                              rating: item.rating?.isNotEmpty == true
                                  ? item.rating![0].rating
                                  : 0.0,
                              reviews: item.rating?.length ?? 0,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
