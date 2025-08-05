import 'package:flutter/material.dart';
import '../stockkeeper/stockkeeper_dashboard.dart';
import '../stockkeeper/stockkeeper_products.dart';
import '../stockkeeper/stockkeeper_inventory.dart';
import '../stockkeeper/stockkeeper_reports.dart';
import '../stockkeeper/stockkeeper_cashier.dart';
import '../stockkeeper/stockkeeper_more.dart';

class StockKeeperHome extends StatelessWidget {
  const StockKeeperHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1623),
      appBar: AppBar(
        title: const Text(
          'Stock Keeper Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0B1623),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Common tiles that work for both desktop and mobile
            final tiles = [
              DashboardTile(
                title: 'Dashboard',
                subtitle: 'Overview',
                icon: Icons.dashboard,
                color: Colors.redAccent,
                onTap: () => _navigateTo(context, const StockKeeperDashboard()),
              ),
              DashboardTile(
                title: 'Products',
                subtitle: 'Manage Items',
                icon: Icons.category,
                color: Colors.green,
                onTap: () => _navigateTo(context, const StockKeeperProducts()),
              ),
              DashboardTile(
                title: 'Stocks',
                subtitle: 'Inventory',
                icon: Icons.inventory,
                color: Colors.blue,
                onTap: () => _navigateTo(context, const StockKeeperInventory()),
              ),
              DashboardTile(
                title: 'Reports',
                subtitle: 'Charts & Data',
                icon: Icons.bar_chart,
                color: Colors.orange,
                onTap: () => _navigateTo(context, const StockKeeperReports()),
              ),
              DashboardTile(
                title: 'Cashier',
                subtitle: 'Billing & Payments',
                icon: Icons.receipt_long,
                color: Colors.purple,
                onTap: () => _navigateTo(context, const StockKeeperCashier()),
              ),
              DashboardTile(
                title: 'More',
                subtitle: 'Settings & Info',
                icon: Icons.more_horiz,
                color: Colors.pink,
                onTap: () => _navigateTo(context, const StockKeeperMore()),
              ),
              DashboardTile(
                title: 'Back',
                subtitle: 'Go Back',
                icon: Icons.arrow_back,
                color: Color.fromARGB(255, 224, 193, 17),
                onTap: () => Navigator.pop(context),
              ),
            ];

            // For larger screens (desktop)
            if (constraints.maxWidth > 800) {
              return GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.2,
                children: tiles,
              );
            } 
            // For mobile screens
            else {
              return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1,
                children: tiles,
              );
            }
          },
        ),
      ),
    );
  }

  // Helper method for navigation to avoid code duplication
  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

class DashboardTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const DashboardTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              offset: const Offset(0, 6),
              blurRadius: 12,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}