import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/item_data.dart';
import 'package:flutter_application_1/screens/main_screen.dart';
import 'package:flutter_application_1/utils/app_colors.dart';
import 'package:flutter_application_1/services/user_services.dart';

class FavProductCard extends StatefulWidget {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int index;
  final String uid;
  final String itemId;

  const FavProductCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.index,
    required this.uid,
    required this.itemId,
  });

  @override
  State<FavProductCard> createState() => FavProductCardState();
}

class FavProductCardState extends State<FavProductCard> {
  bool isFavorite = true;
  final TextEditingController nameController = TextEditingController();

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
                    child: Image.network(
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
                      UserServices().removeFromFavorites(
                        FirebaseAuth.instance.currentUser!.uid,
                        widget.itemId,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Removed from favorites'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(loadScreen: 3),
                        ),
                      );
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
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${widget.price}'),
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
