import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/item_data.dart';
import 'package:flutter_application_1/screens/main_screen.dart';
import 'package:flutter_application_1/services/user_services.dart';
import '../utils/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemScreen extends StatefulWidget {
  final String index;
  final String itemName;
  final double price;
  final String description;
  final String imageUrl;

  const ItemScreen({
    super.key,
    required this.index,
    required this.itemName,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  int quantity = 1;
  final PageController _pageController = PageController();
  bool isLoading = false;
  bool isFavorite = false;

  Future isItemFavoriteOrNot(int index) async {
    bool isFav = await UserServices().isItemFavorite(
      FirebaseAuth.instance.currentUser!.uid,
      index.toString(),
    );
    if (mounted) {
      setState(() {
        isFavorite = isFav;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isItemFavoriteOrNot(int.parse(widget.index));
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // rating
    double rating = double.parse(ItemData()
            .itemDataList[int.parse(widget.index)]
            .rating
            ?.map((r) => r.rating)
            .reduce((a, b) => a > b ? a : b)
            .toString() ??
        '0');

    // list of images
    final List<String> images = [
      widget.imageUrl,
    ];

    // scaffold
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 300,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                ),
                                child: Image.asset(
                                  images[index],
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: SmoothPageIndicator(
                              controller: _pageController,
                              count: images.length,
                              effect: WormEffect(
                                dotColor: Colors.grey.shade400,
                                activeDotColor: AppColors.primary,
                                dotHeight: 8,
                                dotWidth: 8,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          left: 16,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MainScreen(loadScreen: 2),
                                ),
                              );
                            },
                            icon: const Icon(Icons.arrow_back),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primary,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                              if (isFavorite) {
                                UserServices().addToFavorites(
                                  FirebaseAuth.instance.currentUser!.uid,
                                  widget.index.toString(),
                                );
                              } else {
                                UserServices().removeFromFavorites(
                                  FirebaseAuth.instance.currentUser!.uid,
                                  widget.index.toString(),
                                );
                              }
                            },
                            icon: isFavorite
                                ? Icon(
                                    Icons.favorite,
                                    color: AppColors.error,
                                  )
                                : Icon(Icons.favorite_border),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.itemName,
                            style: const TextStyle(
                              color: AppColors.headingText,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                '\$${widget.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  ...List.generate(5, (index) {
                                    return Icon(
                                      index < rating.floor()
                                          ? Icons.star
                                          : index < rating
                                              ? Icons.star_half
                                              : Icons.star_border,
                                      color: Colors.amber,
                                      size: 20,
                                    );
                                  }),
                                  const SizedBox(width: 4),
                                  Text(
                                    rating.toString(),
                                    style: const TextStyle(
                                      color: AppColors.bodyText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Description',
                            style: TextStyle(
                              color: AppColors.headingText,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.description,
                            style: const TextStyle(
                              color: AppColors.bodyText,
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              const Text(
                                'Quantity',
                                style: TextStyle(
                                  color: AppColors.headingText,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: AppColors.borderColor),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: _decrementQuantity,
                                      icon: const Icon(Icons.remove),
                                      color: AppColors.primary,
                                    ),
                                    Text(
                                      quantity.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: _incrementQuantity,
                                      icon: const Icon(Icons.add),
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Reviews',
                            style: TextStyle(
                              color: AppColors.headingText,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: ItemData()
                                    .itemDataList[int.parse(widget.index)]
                                    .rating
                                    ?.length ??
                                0,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 3.5,
                              mainAxisSpacing: 16,
                            ),
                            itemBuilder: (context, index) {
                              return ReviewCard(
                                userEmail: ItemData()
                                        .itemDataList[int.parse(widget.index)]
                                        .rating?[index]
                                        .user ??
                                    'Anonymous',
                                massage: ItemData()
                                        .itemDataList[int.parse(widget.index)]
                                        .rating?[index]
                                        .massage ??
                                    'No massage',
                                rateValue: ItemData()
                                        .itemDataList[int.parse(widget.index)]
                                        .rating?[index]
                                        .rating ??
                                    0,
                              );
                            },
                          ),

                          // Review Cards
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Total: \$${(widget.price * quantity).toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppColors.headingText,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                            });

                            await UserServices().addToCart(
                              FirebaseAuth.instance.currentUser!.uid,
                              widget.index.toString(),
                              quantity,
                            );

                            setState(() {
                              isLoading = false;
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
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
}

class ReviewCard extends StatelessWidget {
  final String userEmail;
  final String massage;
  final double rateValue;
  const ReviewCard(
      {super.key,
      required this.userEmail,
      required this.massage,
      required this.rateValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                userEmail,
                style: const TextStyle(
                  color: AppColors.headingText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                rateValue.toString(),
                style: const TextStyle(
                  color: AppColors.bodyText,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            massage,
            style: const TextStyle(
              color: AppColors.bodyText,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
