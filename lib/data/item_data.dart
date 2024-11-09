import 'package:flutter_application_1/models/item_model.dart';

class ItemData {
  final List<ItemModel> itemDataList = [
    ItemModel(
      id: "1",
      name: "Black Coffee",
      description: "Pure black coffee",
      price: 5.0,
      imageUrl: "assets/images/blackCoffee.jpg",
       
    ),
    ItemModel(
      id: "2", 
      name: "Latte",
      description: "Espresso with milk",
      price: 6.0,
      imageUrl: "assets/images/latte.jpg",
    ),
    ItemModel(
      id: "3",
      name: "Cappuccino",
      description: "Espresso with foam",
      price: 6.5,
      imageUrl: "assets/images/Cappuccino.jpg",
    ),
  ];
}
