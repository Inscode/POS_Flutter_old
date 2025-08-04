import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class POSHomePage extends StatelessWidget {
  const POSHomePage({super.key});

  String getCurrentDateTime() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd hh:mm a');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double tileWidth = constraints.maxWidth / 2;
          double tileHeight = (constraints.maxHeight - 120) / 2;

          return Column(
            children: [
              const SizedBox(height: 40),
              Text(
                'AASA POS SYSTEM',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                getCurrentDateTime(),
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Wrap(
                  spacing: 0,
                  runSpacing: 0,
                  children: const [
                    RoleCard(
                      title: 'Stock Keeper',
                      subtitle: 'manage stock',
                      icon: Icons.inventory_2,
                      color: Colors.orange,
                    ),
                    RoleCard(
                      title: 'ADMIN',
                      subtitle: 'user management',
                      icon: Icons.admin_panel_settings,
                      color: Colors.red,
                    ),
                    RoleCard(
                      title: 'Stock Keeper',
                      subtitle: 'manage stock',
                      icon: Icons.inventory,
                      color: Colors.blue,
                    ),
                    RoleCard(
                      title: 'CASHIER',
                      subtitle: 'quick billing',
                      icon: Icons.receipt_long,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const RoleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return SizedBox(
      width: screen.width / 2,
      height: (screen.height - 120) / 2,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title tapped')),
          );
        },
        child: Container(
          color: color,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 50, color: Colors.white),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
