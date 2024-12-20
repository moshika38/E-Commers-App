import 'package:flutter_application_1/models/item_model.dart';
import 'package:flutter_application_1/models/rating_model.dart';

class ItemData {
  final List<ItemModel> itemDataList = [
    // coffee items
    ItemModel(
      id: "1",
      name: "Black Coffee",
      description: "Pure black coffee",
      price: 5.0,
      imageUrl:
          "https://images.unsplash.com/photo-1521302080334-4bebac2763a6?ixlib=rb-4.0.3&w=400&q=80",
      type: "Coffee",
      rating: [
        RatingModel(
          rating: 4.5,
          massage: "Great classic black coffee, rich flavor!",
          user: "john.smith@email.com",
          itemName: "Black Coffee",
        ),
        RatingModel(
          rating: 4.0,
          massage: "Strong and bold taste, just how I like it",
          user: "coffee.lover@email.com",
          itemName: "Black Coffee",
        ),
      ],
    ),
    ItemModel(
      id: "2",
      name: "Latte",
      description: "Espresso with milk",
      price: 6.0,
      imageUrl:
          "https://images.unsplash.com/photo-1541167760496-1628856ab772?ixlib=rb-4.0.3&w=400&q=80",
      type: "Coffee",
      rating: [
        RatingModel(
          rating: 4.8,
          massage: "Perfect balance of espresso and milk!",
          user: "sarah.jones@email.com",
          itemName: "Latte",
        ),
      ],
    ),
    ItemModel(
      id: "3",
      name: "Cappuccino",
      description: "Espresso with foam",
      price: 6.5,
      imageUrl:
          "https://images.unsplash.com/photo-1534778101976-62847782c213?ixlib=rb-4.0.3&w=400&q=80",
      type: "Coffee",
      rating: [
        RatingModel(
          rating: 4.7,
          massage: "Love the foam art and taste",
          user: "mike.wilson@email.com",
          itemName: "Cappuccino",
        ),
      ],
    ),
    ItemModel(
      id: "4",
      name: "Mocha",
      description: "Espresso with chocolate and milk",
      price: 7.0,
      imageUrl:
          "https://images.unsplash.com/photo-1578314675249-a6910f80cc4e?ixlib=rb-4.0.3&w=400&q=80",
      type: "Coffee",
      rating: [
        RatingModel(
          rating: 4.6,
          massage: "Chocolate and coffee combo is heavenly",
          user: "emma.brown@email.com",
          itemName: "Mocha",
        ),
        RatingModel(
          rating: 4.3,
          massage: "Could use a bit more chocolate, but still good",
          user: "david.clark@email.com",
          itemName: "Mocha",
        ),
      ],
    ),
    ItemModel(
      id: "5",
      name: "Espresso",
      description: "Strong concentrated coffee",
      price: 4.5,
      imageUrl:
          "https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?ixlib=rb-4.0.3&w=400&q=80",
      type: "Coffee",
      rating: [
        RatingModel(
          rating: 4.9,
          massage: "Perfect shot of espresso! Strong and smooth",
          user: "alex.garcia@email.com",
          itemName: "Espresso",
        ),
      ],
    ),
    ItemModel(
      id: "6",
      name: "Americano",
      description: "Espresso diluted with hot water",
      price: 5.5,
      imageUrl:
          "https://images.unsplash.com/photo-1551030173-122aabc4489c?ixlib=rb-4.0.3&w=400&q=80",
      type: "Coffee",
      rating: [
        RatingModel(
          rating: 4.4,
          massage: "Good alternative to regular black coffee",
          user: "lisa.white@email.com",
          itemName: "Americano",
        ),
      ],
    ),
    ItemModel(
      id: "7",
      name: "Macchiato",
      description: "Espresso with a dash of milk foam",
      price: 6.0,
      imageUrl:
          "https://images.unsplash.com/photo-1485808191679-5f86510681a2?ixlib=rb-4.0.3&w=400&q=80",
      type: "Coffee",
      rating: [
        RatingModel(
          rating: 4.7,
          massage: "Love the subtle milk foam touch",
          user: "chris.miller@email.com",
          itemName: "Macchiato",
        ),
        RatingModel(
          rating: 4.5,
          massage: "Perfect afternoon pick-me-up",
          user: "rachel.taylor@email.com",
          itemName: "Macchiato",
        ),
      ],
    ),

    // tea items
    ItemModel(
      id: "8",
      name: "Green Tea",
      description: "Classic Japanese green tea with a delicate, earthy flavor",
      price: 4.5,
      imageUrl:
          "https://images.unsplash.com/photo-1627435601361-ec25f5b1d0e5?ixlib=rb-4.0.3&w=400&q=80",
      type: "Tea",
      rating: [
        RatingModel(
          rating: 4.6,
          massage: "So refreshing and calming",
          user: "emma.wilson@email.com",
          itemName: "Green Tea",
        ),
        RatingModel(
          rating: 4.8,
          massage: "Perfect authentic taste",
          user: "david.chen@email.com",
          itemName: "Green Tea",
        ),
      ],
    ),
    ItemModel(
      id: "9",
      name: "Earl Grey",
      description: "Black tea flavored with oil of bergamot",
      price: 4.0,
      imageUrl:
          "https://images.unsplash.com/photo-1597318181409-cf64d0b5d8a2?ixlib=rb-4.0.3&w=400&q=80",
      type: "Tea",
      rating: [
        RatingModel(
          rating: 4.7,
          massage: "Love the bergamot aroma",
          user: "sophia.brown@email.com",
          itemName: "Earl Grey",
        ),
      ],
    ),
    ItemModel(
      id: "10",
      name: "Chamomile Tea",
      description: "Caffeine-free herbal tea with calming properties",
      price: 4.0,
      imageUrl:
          "https://images.unsplash.com/photo-1594631252845-29fc4cc8cde9?ixlib=rb-4.0.3&w=400&q=80",
      type: "Tea",
      rating: [
        RatingModel(
          rating: 4.5,
          massage: "Perfect before bedtime",
          user: "michael.jones@email.com",
          itemName: "Chamomile Tea",
        ),
        RatingModel(
          rating: 4.6,
          massage: "Very soothing and relaxing",
          user: "olivia.smith@email.com",
          itemName: "Chamomile Tea",
        ),
      ],
    ),
    ItemModel(
      id: "11",
      name: "English Breakfast",
      description: "Traditional blend of black teas",
      price: 4.5,
      imageUrl:
          "https://images.unsplash.com/photo-1587888637140-849b25d80ef9?ixlib=rb-4.0.3&w=400&q=80",
      type: "Tea",
      rating: [
        RatingModel(
          rating: 4.8,
          massage: "Strong and perfect with milk",
          user: "james.wilson@email.com",
          itemName: "English Breakfast",
        ),
      ],
    ),

    ItemModel(
      id: "12",
      name: "Chocolate Croissant",
      description: "Buttery, flaky croissant filled with rich chocolate",
      price: 4.5,
      imageUrl:
          "https://images.unsplash.com/photo-1549903072-7e6e0bedb7fb?ixlib=rb-4.0.3&w=400&q=80",
      type: "Pastries",
      rating: [
        RatingModel(
          rating: 4.7,
          massage: "Perfect balance of chocolate and buttery pastry!",
          user: "emma.davis@email.com",
          itemName: "Chocolate Croissant",
        ),
        RatingModel(
          rating: 4.8,
          massage: "My favorite breakfast pastry",
          user: "noah.wilson@email.com",
          itemName: "Chocolate Croissant",
        ),
      ],
    ),
    ItemModel(
      id: "13",
      name: "Almond Danish",
      description: "Flaky pastry topped with sliced almonds and sweet glaze",
      price: 4.75,
      imageUrl:
          "https://images.unsplash.com/photo-1509365465985-25d11c17e812?ixlib=rb-4.0.3&w=400&q=80",
      type: "Pastries",
      rating: [
        RatingModel(
          rating: 4.6,
          massage: "Love the almond flavor and flaky texture",
          user: "ava.brown@email.com",
          itemName: "Almond Danish",
        ),
      ],
    ),
    ItemModel(
      id: "14",
      name: "Cinnamon Roll",
      description:
          "Classic pastry swirled with cinnamon and topped with cream cheese frosting",
      price: 5.0,
      imageUrl:
          "https://images.unsplash.com/photo-1516832378525-ccd1bbeb9115?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Q2lubmFtb24lMjBSb2xsfGVufDB8fDB8fHww",
      type: "Pastries",
      rating: [
        RatingModel(
          rating: 4.9,
          massage: "Best cinnamon roll I've ever had!",
          user: "liam.taylor@email.com",
          itemName: "Cinnamon Roll",
        ),
        RatingModel(
          rating: 4.7,
          massage: "Perfect amount of frosting and cinnamon",
          user: "sophia.miller@email.com",
          itemName: "Cinnamon Roll",
        ),
      ],
    ),
    ItemModel(
      id: "15",
      name: "Fruit Danish",
      description:
          "Buttery pastry filled with seasonal fruits and vanilla custard",
      price: 4.95,
      imageUrl:
          "https://images.unsplash.com/photo-1623428454614-abaf00244e52?ixlib=rb-4.0.3&w=400&q=80",
      type: "Pastries",
      rating: [
        RatingModel(
          rating: 4.5,
          massage: "Fresh fruits and creamy custard make this amazing",
          user: "oliver.jones@email.com",
          itemName: "Fruit Danish",
        ),
      ],
    ),

    ItemModel(
      id: "16",
      name: "Chocolate Cake",
      description: "Rich, moist chocolate cake layered with chocolate ganache",
      price: 6.50,
      imageUrl:
          "https://images.unsplash.com/photo-1578985545062-69928b1d9587?ixlib=rb-4.0.3&w=400&q=80",
      type: "Desserts",
      rating: [
        RatingModel(
          rating: 4.8,
          massage: "Decadent and delicious! Perfect for chocolate lovers",
          user: "emma.wilson@email.com",
          itemName: "Chocolate Cake",
        ),
        RatingModel(
          rating: 4.9,
          massage: "The ganache is to die for!",
          user: "noah.clark@email.com",
          itemName: "Chocolate Cake",
        ),
      ],
    ),
    ItemModel(
      id: "17",
      name: "Cheesecake",
      description:
          "Classic New York style cheesecake with graham cracker crust",
      price: 7.00,
      imageUrl:
          "https://images.unsplash.com/photo-1533134242443-d4fd215305ad?ixlib=rb-4.0.3&w=400&q=80",
      type: "Desserts",
      rating: [
        RatingModel(
          rating: 4.7,
          massage: "Creamy and smooth - just perfect!",
          user: "isabella.white@email.com",
          itemName: "Cheesecake",
        ),
      ],
    ),
    ItemModel(
      id: "18",
      name: "Tiramisu",
      description:
          "Italian dessert with coffee-soaked ladyfingers and mascarpone cream",
      price: 6.75,
      imageUrl:
          "https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?ixlib=rb-4.0.3&w=400&q=80",
      type: "Desserts",
      rating: [
        RatingModel(
          rating: 4.9,
          massage: "Authentic taste, reminds me of Italy!",
          user: "lucas.martin@email.com",
          itemName: "Tiramisu",
        ),
        RatingModel(
          rating: 4.8,
          massage: "The coffee flavor is perfectly balanced",
          user: "mia.anderson@email.com",
          itemName: "Tiramisu",
        ),
      ],
    ),
    ItemModel(
      id: "19",
      name: "Apple Pie",
      description:
          "Traditional apple pie with flaky crust and cinnamon-spiced filling",
      price: 5.95,
      imageUrl:
          "https://images.unsplash.com/photo-1621743478914-cc8a86d7e7b5?ixlib=rb-4.0.3&w=400&q=80",
      type: "Desserts",
      rating: [
        RatingModel(
          rating: 4.6,
          massage: "Just like grandma used to make!",
          user: "ethan.moore@email.com",
          itemName: "Apple Pie",
        ),
      ],
    )
  ];

  final Map<String, Map<String, dynamic>> items = {
    // Your item data here
    'item1': {
      'image': 'path/to/image1',
      'name': 'Item 1',
      'description': 'Description 1',
      'price': 9.99,
    },
    // Add more items as needed
  };
}
