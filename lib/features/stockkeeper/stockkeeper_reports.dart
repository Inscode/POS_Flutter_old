import 'package:flutter/material.dart';

class StockKeeperReports extends StatelessWidget {
  const StockKeeperReports({Key? key}) : super(key: key);  // Constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Keeper Products'),
        backgroundColor: const Color(0xFF0B1623),
      ),
      body: const Center(
        child: Text(
          'Welcome to Stock Keeper Products!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
