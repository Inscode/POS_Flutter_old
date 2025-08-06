import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart'; // Feather icons
import '../stockkeeper/products/add_item_page.dart';
import '../stockkeeper/products/add_product_page.dart';
import '../stockkeeper/products/supplier_page.dart';



class StockKeeperProducts extends StatelessWidget {
  const StockKeeperProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1623),
      appBar: AppBar(
        title: const Text(
          'Stock Keeper Products',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0B1623),
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1000,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final tiles = [
                  DashboardTile(
                    title: 'Add Item',
                    subtitle: 'Create New Item',
                    icon: Feather.plus_circle,
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AddItemPage()),
                      );
                    },
                  ),
                  DashboardTile(
                    title: 'Add Product',
                    subtitle: 'New Product Entry',
                    icon: Feather.plus_square,
                    color: Colors.blue,
                   onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AddProductPage()),
                      );
                    },
                  ),
                  DashboardTile(
                    title: 'Suppliers',
                    subtitle: 'Manage Vendors',
                    icon: Feather.truck,
                    color: Colors.orange,
                   onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SupplierPage()),
                      );
                    },
                  ),
                  DashboardTile(
                    title: 'Back',
                    subtitle: 'Go Back',
                    icon: Feather.arrow_left,
                    color: const Color.fromARGB(255, 224, 193, 17),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ];

                return GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: constraints.maxWidth > 800 ? 4 : 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.2,
                  children: tiles.map((tile) => tile).toList(),
                );
              },
            ),
          ),
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
  final VoidCallback onTap;

  const DashboardTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

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
