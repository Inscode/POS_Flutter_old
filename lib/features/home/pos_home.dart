import 'package:flutter/material.dart';

class POSHomePage extends StatelessWidget {
  const POSHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A), // Dark blue background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Text(
                'POS SYSTEM',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Center(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: const [
                      RoleCard(
                        title: 'Stock Keeper',
                        subtitle: 'Manage Stock',
                        icon: Icons.inventory_2,
                        color: Colors.orange,
                      ),
                      RoleCard(
                        title: 'Admin',
                        subtitle: 'User Management',
                        icon: Icons.admin_panel_settings,
                        color: Colors.red,
                      ),
                      RoleCard(
                        title: 'Manager',
                        subtitle: 'Oversee Sales',
                        icon: Icons.supervisor_account,
                        color: Colors.blue,
                      ),
                      RoleCard(
                        title: 'Cashier',
                        subtitle: 'Quick Billing',
                        icon: Icons.receipt_long,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),

              // ✅ Bottom Footer
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Powered by AASA IT',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
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
    return SizedBox(
      width: 150,
      height: 150,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title tapped')),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: color,
          elevation: 4,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: Colors.white),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
