// import 'package:flutter/material.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart'; // ✅ Correct import

// class StockKeeperDashboard extends StatelessWidget {
//   const StockKeeperDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0B1623), // Dark background
//       appBar: AppBar(
//         title: const Text(
//           'Stock Keeper Dashboard',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: const Color(0xFF0B1623),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             // Check if it's a larger screen (desktop) or mobile
//             if (constraints.maxWidth > 800) {
//               return GridView.count(
//                 crossAxisCount: 4, // 4 tiles per row on desktop
//                 crossAxisSpacing: 20,
//                 mainAxisSpacing: 20,
//                 childAspectRatio: 1.2, // Adjust size for desktop
//                 children: const [
//                   DashboardTile(
//                     title: 'Monthly Sales',
//                     subtitle: 'Overview',
//                     icon: Feather.trending_up, // 🟢 Feather Icons
//                     color: Colors.redAccent,
//                   ),
//                   DashboardTile(
//                     title: 'Total Sales',
//                     subtitle: 'Sales Overview',
//                     icon: Feather.credit_card, // 🟢 Feather Icons
//                     color: Colors.green,
//                   ),
//                   DashboardTile(
//                     title: 'Net Profit',
//                     subtitle: 'Profit Calculation',
//                     icon: Feather.bar_chart, // 🟢 Feather Icons
//                     color: Colors.blue,
//                   ),
//                   DashboardTile(
//                     title: 'Top Product',
//                     subtitle: 'Best Seller',
//                     icon: Feather.package, // 🟢 Feather Icons
//                     color: Colors.orange,
//                   ),
//                   DashboardTile(
//                     title: 'Daily Sales Amount',
//                     subtitle: 'Sales Today',
//                     icon: Feather.dollar_sign, // 🟢 Feather Icons
//                     color: Colors.purple,
//                   ),
//                   DashboardTile(
//                     title: 'Top Product Category',
//                     subtitle: 'Category Overview',
//                     icon: Feather.layers, // 🟢 Feather Icons
//                     color: Colors.pink,
//                   ),
//                   // Back Button
//                   DashboardTile(
//                     title: 'Back',
//                     subtitle: 'Go Back',
//                     icon: Feather.arrow_left, // 🟢 Feather Icons
//                     color: Color.fromARGB(255, 224, 193, 17),
//                   ),
//                 ],
//               );
//             } else {
//               // Mobile view: same as before with the BACK tile included
//               return GridView.count(
//                 crossAxisCount: 2, // 2 tiles per row on mobile
//                 crossAxisSpacing: 20,
//                 mainAxisSpacing: 20,
//                 childAspectRatio: 1,
//                 children: [
//                   DashboardTile(
//                     title: 'Monthly Sales',
//                     subtitle: 'Overview',
//                     icon: Feather.trending_up, // 🟢 Feather Icons
//                     color: Colors.redAccent,
//                   ),
//                   DashboardTile(
//                     title: 'Total Sales',
//                     subtitle: 'Sales Overview',
//                     icon: Feather.credit_card, // 🟢 Feather Icons
//                     color: Colors.green,
//                   ),
//                   DashboardTile(
//                     title: 'Net Profit',
//                     subtitle: 'Profit Calculation',
//                     icon: Feather.bar_chart, // 🟢 Feather Icons
//                     color: Colors.blue,
//                   ),
//                   DashboardTile(
//                     title: 'Top Product',
//                     subtitle: 'Best Seller',
//                     icon: Feather.package, // 🟢 Feather Icons
//                     color: Colors.orange,
//                   ),
//                   DashboardTile(
//                     title: 'Daily Sales Amount',
//                     subtitle: 'Sales Today',
//                     icon: Feather.dollar_sign, // 🟢 Feather Icons
//                     color: Colors.purple,
//                   ),
//                   DashboardTile(
//                     title: 'Top Product Category',
//                     subtitle: 'Category Overview',
//                     icon: Feather.layers, // 🟢 Feather Icons
//                     color: Colors.pink,
//                   ),
//                   DashboardTile(
//                     title: 'Back',
//                     subtitle: 'Go Back',
//                     icon: Feather.arrow_left, // 🟢 Feather Icons
//                     color: Color.fromARGB(255, 224, 193, 17),
//                   ),
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class DashboardTile extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final IconData icon;
//   final Color color;

//   const DashboardTile({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.icon,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('$title clicked')),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: color.withOpacity(0.4),
//               offset: const Offset(0, 6),
//               blurRadius: 12,
//             )
//           ],
//         ),
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(icon, size: 40, color: Colors.white),
//               const SizedBox(height: 12),
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               Text(
//                 subtitle,
//                 style: const TextStyle(
//                   fontSize: 13,
//                   color: Colors.white70,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
