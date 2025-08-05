import 'package:flutter/material.dart';

class StockkeeperDashboard extends StatelessWidget {
  const StockkeeperDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock Keeper Dashboard')),
      body: const Center(child: Text('Welcome, Stock Keeper!')),
    );
  }
}
