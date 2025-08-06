import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart'; // For Feather icons

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
      maxWidth: 1000, // Max width for desktop layout
    ),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tiles = const [
            DashboardTile(
              title: 'Add Item',
              subtitle: 'Create New Item',
              icon: Feather.plus_circle,
              color: Colors.green,
            ),
            DashboardTile(
              title: 'Add Product',
              subtitle: 'New Product Entry',
              icon: Feather.plus_square,
              color: Colors.blue,
            ),
            DashboardTile(
              title: 'Suppliers',
              subtitle: 'Manage Vendors',
              icon: Feather.truck,
              color: Colors.orange,
            ),
            DashboardTile(
              title: 'Back',
              subtitle: 'Go Back',
              icon: Feather.arrow_left,
              color: Color.fromARGB(255, 224, 193, 17),
            ),
          ];

          return GridView.count(
            shrinkWrap: true, // ✅ Prevent full scroll space
            crossAxisCount: constraints.maxWidth > 800 ? 4 : 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.2,
            children: tiles.map((tile) {
              return InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${tile.title} clicked')),
                  );

                  if (tile.title == 'Back') {
                    Navigator.pop(context);
                  }
                },
                child: tile,
              );
            }).toList(),
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

  const DashboardTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            offset: const Offset(0, 6),
            blurRadius: 12,
          )
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
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
