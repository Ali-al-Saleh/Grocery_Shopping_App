import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const GroceryApp());
}

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery Shopping App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const Home(),
    );
  }
}
