import 'package:flutter/material.dart';
import '../stockkeeper/stockkeeper_dashboard.dart';
import '../stockkeeper/stockkeeper_products.dart'; // Import StockKeeperDashboard
import '../stockkeeper/stockkeeper_inventory.dart';
import '../stockkeeper/stockkeeper_reports.dart';
import '../stockkeeper/stockkeeper_cashier.dart';
import '../stockkeeper/stockkeeper_more.dart';

class StockKeeperHome extends StatelessWidget {
  const StockKeeperHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1623), // Dark background
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
            // Check if it's a larger screen (desktop) or mobile
            if (constraints.maxWidth > 800) {
              return GridView.count(
                crossAxisCount: 4, // 4 tiles per row on desktop
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.2, // Adjust size for desktop
                children: [
                  DashboardTile(
                    title: 'Dashboard',
                    subtitle: 'Overview',
                    icon: Icons.dashboard, // 🟢 Dashboard Icon
                    color: Colors.redAccent,
                    onTap: () {
                      // Navigate to the StockKeeperDashboard
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StockKeeperDashboard(),
                        ),
                      );
                    },
                  ),
                  DashboardTile(
                    title: 'Products',
                    subtitle: 'Manage Items',
                    icon: Icons.category, // 🟢 Category Icon
                    color: Colors.green,
                    onTap: () {
                      // Navigate to the Products page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StockKeeperProducts(),
                        ),
                      );
                    },
                  ),
                  DashboardTile(
                    title: 'Stocks',
                    subtitle: 'Inventory',
                    icon: Icons.inventory, // 🟢 Inventory Icon
                    color: Colors.blue,
                    onTap: () {
                      // Navigate to the Stocks page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StockKeeperInventory(),
                        ),
                      );
                    },
                  ),
                  DashboardTile(
                    title: 'Reports',
                    subtitle: 'Charts & Data',
                    icon: Icons.bar_chart, // 🟢 Bar Chart Icon
                    color: Colors.orange,
                    onTap: () {
                      // Navigate to the Reports page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StockKeeperReports(),
                        ),
                      );
                    },
                  ),
                  DashboardTile(
                    title: 'Cashier',
                    subtitle: 'Billing & Payments',
                    icon: Icons.receipt_long, // 🟢 Receipt Icon
                    color: Colors.purple,
                    onTap: () {
                      // Navigate to the Cashier page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StockKeeperCashier(),
                        ),
                      );
                    },
                  ),
                  DashboardTile(
                    title: 'More',
                    subtitle: 'Settings & Info',
                    icon: Icons.more_horiz, // 🟢 More Icon
                    color: Colors.pink,
                    onTap: () {
                      // Navigate to More Settings/Info page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StockKeeperMore(),
                        ),
                      );
                    },
                  ),
                  DashboardTile(
                    title: 'Back',
                    subtitle: 'Go Back',
                    icon: Icons.arrow_back, // 🟢 Arrow Back Icon
                    color: Color.fromARGB(255, 224, 193, 17),
                    onTap: () {
                      Navigator.pop(context); // Go back to the previous screen
                    },
                  ),
                ],
              );
            } else {
              // Mobile view: same as before
              return GridView.count(
                crossAxisCount: 2, // 2 tiles per row on mobile
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1,
                children: [
                  DashboardTile(
                    title: 'Dashboard',
                    subtitle: 'Overview',
                    icon: Icons.dashboard, // 🟢 Dashboard Icon
                    color: Colors.redAccent,
                    onTap: () {
                      // Navigate to StockKeeperDashboard
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StockKeeperDashboard(),
                        ),
                      );
                    },
                  ),
                  DashboardTile(
                    title: 'Products',
                    subtitle: 'Manage Items',
                    icon: Icons.category, // 🟢 Category Icon
                    color: Colors.green,
                    onTap: () {
                      // Navigate to the Products page (add the necessary route if needed)
                    },
                  ),
                  DashboardTile(
                    title: 'Stocks',
                    subtitle: 'Inventory',
                    icon: Icons.inventory, // 🟢 Inventory Icon
                    color: Colors.blue,
                    onTap: () {
                      // Navigate to the Stocks page (add the necessary route if needed)
                    },
                  ),
                  DashboardTile(
                    title: 'Reports',
                    subtitle: 'Charts & Data',
                    icon: Icons.bar_chart, // 🟢 Bar Chart Icon
                    color: Colors.orange,
                    onTap: () {
                      // Navigate to the Reports page (add the necessary route if needed)
                    },
                  ),
                  DashboardTile(
                    title: 'Cashier',
                    subtitle: 'Billing & Payments',
                    icon: Icons.receipt_long, // 🟢 Receipt Icon
                    color: Colors.purple,
                    onTap: () {
                      // Navigate to the Cashier Dashboard (add the necessary route if needed)
                    },
                  ),
                  DashboardTile(
                    title: 'More',
                    subtitle: 'Settings & Info',
                    icon: Icons.more_horiz, // 🟢 More Icon
                    color: Colors.pink,
                    onTap: () {
                      // Navigate to the More Settings/Info page (add the necessary route if needed)
                    },
                  ),
                  DashboardTile(
                    title: 'Back',
                    subtitle: 'Go Back',
                    icon: Icons.arrow_back, // 🟢 Arrow Back Icon
                    color: Color.fromARGB(255, 224, 193, 17),
                    onTap: () {
                      Navigator.pop(context); // Go back to the previous screen
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class DashboardTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap; // Accept the onTap callback for navigation

  const DashboardTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap, // Pass the onTap callback
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Trigger the onTap navigation
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
