import 'package:flutter_application_1/models/item_model.dart';

class ItemData {
  final List<ItemModel> itemDataList = [
    ItemModel(
      id: "1",
      name: "Black Coffee",
      description: "Black coffee is the simplest and healthiest coffee type available. The ground coffee beans are steamed by hot water within a drip machine, and that is it. Because it is served as is, the coffee will taste strong, and be at its most bitter.",
      price: 5.0,
      imageUrl: "assets/images/black_coffee.jpg",
    ),
    ItemModel(
      id: "2", 
      name: "Latte",
      description: "A latte is a coffee drink made with espresso and steamed milk. The term comes from the Italian coffee latte, meaning coffee and milk.",
      price: 6.0,
      imageUrl: "assets/images/latte.jpg",
    ),
    ItemModel(
      id: "3",
      name: "Cappuccino",
      description: "A cappuccino is an espresso-based coffee drink that originated in Italy and is prepared with steamed milk foam.",
      price: 6.5,
      imageUrl: "assets/images/cappuccino.jpg",
    ),
  ];
}
