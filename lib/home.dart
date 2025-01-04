import 'package:flutter/material.dart';
import 'grocery.dart';
import 'total_calculation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  final TotalCalculator calculator = TotalCalculator();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  void fetchItems() async {
    setState(() {
      isLoading = true;
      calculator.total = 0.0;
      for (var item in groceryItems) {
        item.quantitySelected = 0;
      }
    });
    await fetchGroceryItems((success) {
      setState(() {
        isLoading = !success;
      });
    });
  }

  void updateTotal() {
    double total = 0.0;
    for (var item in groceryItems) {
      total += item.quantitySelected * item.price;
    }
    setState(() {
      calculator.total = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = groceryItems
        .where((item) =>
        item.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Grocery Picker')),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchItems,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search for items',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : filteredItems.isEmpty
          ? const Center(
        child: Text('No items found'),
      )
          : ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    item.imageUrl,
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image);
                    },
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            'Unit Price: \$${item.price.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (item.quantitySelected > 0) {
                              item.quantitySelected--;
                            }
                            updateTotal();
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(item.quantitySelected.toString()),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            item.quantitySelected++;
                            updateTotal();
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.green,
        padding: const EdgeInsets.all(16),
        child: Text(
          'Total: \$${calculator.total.toStringAsFixed(2)}',
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
