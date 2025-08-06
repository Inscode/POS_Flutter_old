import 'package:flutter/material.dart';

class AddItemPage extends StatelessWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1623),
      appBar: AppBar(
        title: const Text(
          'Add Item',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0B1623),
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'This is the Add Item Page',
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }
}
