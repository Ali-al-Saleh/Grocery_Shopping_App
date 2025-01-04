import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseURL = 'http://localhost/grocery_app';

List<GroceryItem> groceryItems = [];

Future<void> fetchGroceryItems(Function(bool) callback) async {
  try {
    final url = Uri.parse('$baseURL/getGroceryItems.php');
    final response = await http.get(url).timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      groceryItems.clear();
      for (var item in jsonData) {
        groceryItems.add(GroceryItem.fromJson(item));
      }
      callback(true);
    } else {
      callback(false);
    }
  } catch (e) {
    callback(false);
  }
}

class GroceryItem {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  int quantitySelected;
  bool isSelected;

  GroceryItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantitySelected = 0,
    this.isSelected = false,
  });

  factory GroceryItem.fromJson(Map<String, dynamic> json) {
    return GroceryItem(
      id: int.parse(json['pid']),
      name: json['name'],
      price: double.parse(json['price']),
      imageUrl: json['image_url'] ?? '',
    );
  }

  @override
  String toString() {
    return 'ID: $id\nName: $name\nPrice: \$${price.toStringAsFixed(2)}\nQuantity: $quantitySelected';
  }
}
