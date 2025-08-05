// lib/main.dart
import 'package:flutter/material.dart';
import 'features/home/pos_home.dart'; // ✅ Import POSHomePage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AASA POS System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const POSHomePage(), // ✅ Start directly with the home page
    );
  }
}
