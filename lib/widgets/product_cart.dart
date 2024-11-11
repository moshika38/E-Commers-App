import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/item_data.dart';
import 'package:flutter_application_1/utils/app_colors.dart';
import 'package:flutter_application_1/services/user_services.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int index;
  final String uid;

  const ProductCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.index,
    required this.uid,
  });

  @override
  State<ProductCard> createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  final TextEditingController nameController = TextEditingController();
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
    isItemFavoriteOrNot(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.focusShadow,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      widget.imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
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
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(
                      ItemData()
                              .itemDataList[widget.index]
                              .rating
                              ?.map((r) => r.rating)
                              .reduce((a, b) => a > b ? a : b)
                              .toString() ??
                          '0',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Text(
                  widget.description,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${widget.price}'),
                    IconButton(
                      icon:
                          const Icon(Icons.add, color: Colors.white, size: 20),
                      onPressed: () {
                        // add to cart
                        UserServices().addToCart(
                          FirebaseAuth.instance.currentUser!.uid,
                          widget.index.toString(),
                          1,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Added to cart'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
