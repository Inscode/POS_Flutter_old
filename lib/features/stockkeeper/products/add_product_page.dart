import 'package:flutter/material.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1623),
      appBar: AppBar(
        title: const Text(
          'Add Product',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0B1623),
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'This is the Add Product Page',
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }
}
