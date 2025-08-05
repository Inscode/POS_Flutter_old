import 'package:flutter/material.dart';

class CashierDashboard extends StatelessWidget {
  const CashierDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cashier Dashboard')),
      body: const Center(child: Text('Welcome, Cashier!')),
    );
  }
}
