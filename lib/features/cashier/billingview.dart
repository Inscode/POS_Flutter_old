// import 'package:flutter/material.dart';

// class CashierViewPage extends StatefulWidget {
//   const CashierViewPage({super.key});

//   @override
//   State<CashierViewPage> createState() => _CashierViewPageState();
// }

// class _CashierViewPageState extends State<CashierViewPage> {
//   final List<String> categories = ['Drinks', 'Snacks', 'Grocery', 'Bakery'];
//   final Map<String, List<Map<String, dynamic>>> itemsByCategory = {
//     'Drinks': [
//       {
//         'name': 'Coke',
//         'batches': [
//           {'batchID': '123234', 'pprice': 120.00, 'price': 150.0, 'quantity': 20},
//           {'batchID': '123237', 'pprice': 130.00, 'price': 160.0, 'quantity': 20},
//         ]
//       },
//     ],
//     'Snacks': [
//       {
//         'name': 'Chips',
//         'batches': [
//           {'batchID': '223234', 'pprice': 90.00, 'price': 100.0, 'quantity': 30},
//         ],
//       },
//       {
//         'name': 'Chocolate',
//         'batches': [
//           {'batchID': '223237', 'pprice': 100.00, 'price': 120.0, 'quantity': 25},
//         ],
//       },
//     ],
//     'Grocery': [
//       {
//         'name': 'Rice',
//         'batches': [
//           {'batchID': '323234', 'pprice': 80.00, 'price': 90.0, 'quantity': 50},
//         ],
//       },
//       {
//         'name': 'Sugar',
//         'batches': [
//           {'batchID': '323237', 'pprice': 60.00, 'price': 70.0, 'quantity': 40},
//         ],
//       },
//     ],
//     'Bakery': [
//       {
//         'name': 'Bread',
//         'batches': [
//           {'batchID': '423234', 'pprice': 70.00, 'price': 80.0, 'quantity': 15},
//         ],
//       },
//       {
//         'name': 'Bun',
//         'batches': [
//           {'batchID': '423237', 'pprice': 50.00, 'price': 60.0, 'quantity': 20},
//         ],
//       },
//     ],
//   };

//   final List<Map<String, dynamic>> cartItems = [];
//   String searchQuery = '';
//   bool isPercentageDiscount = true;
//   double discount = 0;

//  void _addToCart(Map<String, dynamic> batch, {int quantity = 1}) {
//   final existingIndex = cartItems.indexWhere(
//     (i) => i['name'] == batch['name'] && i['batchID'] == batch['batchID'],
//   );
//   if (existingIndex >= 0) {
//     cartItems[existingIndex]['quantity'] += quantity;
//   } else {
//     cartItems.add({
//       'name': batch['name'],
//       'price': batch['price'],
//       'batchID': batch['batchID'],
//       'quantity': quantity,
//       'itemDiscount': 0.0,
//       'isItemDiscountPercentage': false,
//     });
//   }
//   setState(() {});
// }

//  void _showBatchSelectionDialog(Map<String, dynamic> item) {
//   final batchList = item['batches'] ?? [];
//   if (batchList.isEmpty) return;

//   if (batchList.length == 1) {
//     final selectedBatch = batchList[0];
//     selectedBatch['name'] = item['name']; // attach item name to batch
//     _showQuantityInputDialog(selectedBatch);
//     return;
//   }

//   int selectedBatchIndex = 0;
//   showDialog(
//     context: context,
//     builder: (_) => AlertDialog(
//       title: Text('Select Batch for ${item['name']}'),
//       content: SizedBox(
//         width: double.maxFinite,
//         child: ListView.builder(
//           shrinkWrap: true,
//           itemCount: batchList.length,
//           itemBuilder: (context, index) {
//             final batch = batchList[index];
//             return ListTile(
//               title: Text('Batch: ${batch['batchID']} - Price: Rs. ${batch['price']}'),
//               onTap: () {
//                 batch['name'] = item['name']; // attach name for cart
//                 Navigator.pop(context); // close batch dialog
//                 _showQuantityInputDialog(batch);
//               },
//             );
//           },
//         ),
//       ),
//     ),
//   );
// }

//   void _showQuantityInputDialog(Map<String, dynamic> batch) {
//   int quantity = 1;
//   showDialog(
//     context: context,
//     builder: (_) => AlertDialog(
//       title: Text('Enter quantity for ${batch['name']} (Batch: ${batch['batchID']})'),
//       content: TextField(
//         autofocus: true,
//         keyboardType: TextInputType.number,
//         onChanged: (value) {
//           quantity = int.tryParse(value) ?? 1;
//         },
//         onSubmitted: (value) {
//           quantity = int.tryParse(value) ?? 1;
//           Navigator.pop(context); // Close the dialog
//           _addToCart(batch, quantity: quantity); // Add batch to cart
//         },
//         decoration: const InputDecoration(hintText: 'Quantity'),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context); // Close the dialog
//             _addToCart(batch, quantity: quantity);
//           },
//           child: const Text('Add'),
//         ),
//       ],
//     ),
//   );
// }

//   void _editCartItem(int index) {
//     int quantity = cartItems[index]['quantity'];
//     double itemDiscount = cartItems[index]['itemDiscount'] ?? 0.0;
//     bool isPercentage = cartItems[index]['isItemDiscountPercentage'] ?? false;

//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text('Edit ${cartItems[index]['name']}'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               decoration: const InputDecoration(labelText: 'Quantity'),
//               keyboardType: TextInputType.number,
//               controller: TextEditingController(text: quantity.toString()),
//               onChanged: (value) {
//                 quantity = int.tryParse(value) ?? quantity;
//               },
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: isPercentage ? 'Discount (%)' : 'Discount (Rs)'),
//               keyboardType: TextInputType.number,
//               controller: TextEditingController(text: itemDiscount.toString()),
//               onChanged: (value) {
//                 itemDiscount = double.tryParse(value) ?? itemDiscount;
//               },
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Discount Type: '),
//                 DropdownButton<bool>(
//                   value: isPercentage,
//                   items: const [
//                     DropdownMenuItem(value: true, child: Text('%')),
//                     DropdownMenuItem(value: false, child: Text('Rs')),
//                   ],
//                   onChanged: (value) => setState(() => isPercentage = value!),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 if (quantity <= 0) {
//                   cartItems.removeAt(index);
//                 } else {
//                   cartItems[index]['quantity'] = quantity;
//                   cartItems[index]['itemDiscount'] = itemDiscount;
//                   cartItems[index]['isItemDiscountPercentage'] = isPercentage;
//                 }
//               });
//               Navigator.pop(context);
//             },
//             child: const Text('Update'),
//           ),
//         ],
//       ),
//     );
//   }

//   double _calculateTotal() {
//     double total = 0;
//     for (var item in cartItems) {
//       double unitPrice = item['price'];
//       double discount = item['itemDiscount'] ?? 0;
//       if (item['isItemDiscountPercentage'] == true) {
//         unitPrice -= unitPrice * discount / 100;
//       } else {
//         unitPrice -= discount;
//       }
//       total += unitPrice * item['quantity'];
//     }
//     if (isPercentageDiscount) {
//       return total - (total * discount / 100);
//     } else {
//       return total - discount;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final searchedItems = itemsByCategory.entries.expand((entry) => entry.value).where((item) =>
//         item['name'].toLowerCase().contains(searchQuery.toLowerCase())).toList();

//     return Theme(
//       data: ThemeData.dark(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Cashier - Billing'),
//           backgroundColor: const Color(0xFF0D1B2A),
//         ),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: TextField(
//                 onChanged: (value) => setState(() => searchQuery = value),
//                 decoration: InputDecoration(
//                   hintText: 'Search item or scan barcode...',
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//               ),
//             ),
//             if (searchQuery.isEmpty) ...[
//               Expanded(
//                 child: GridView.count(
//                   crossAxisCount: 2,
//                   padding: const EdgeInsets.all(10),
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   children: categories.map((cat) {
//                     return GestureDetector(
//                       onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => CategoryItemsPage(
//                             category: cat,
//                             items: itemsByCategory[cat]!,
//                             onItemSelected: _showBatchSelectionDialog,
//                           ),
//                         ),
//                       ),
//                       child: Card(
//                         color: Colors.blueGrey.shade200,
//                         child: Center(child: Text(cat, style: const TextStyle(fontSize: 18))),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ] else ...[
//               Expanded(
//                 child: ListView(
//                   children: searchedItems.map((item) => ListTile(
//                     title: Text(item['name']),
//                     trailing: Text('Rs. ${item['price']}'),
//                     onTap: () => _showBatchSelectionDialog(item),
//                   )).toList(),
//                 ),
//               )
//             ],
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('Bill Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("Discount: "),
//                 SizedBox(
//                   width: 80,
//                   child: TextField(
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(hintText: '0'),
//                     onChanged: (value) => setState(() => discount = double.tryParse(value) ?? 0),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 DropdownButton<bool>(
//                   value: isPercentageDiscount,
//                   items: const [
//                     DropdownMenuItem(value: true, child: Text('%')),
//                     DropdownMenuItem(value: false, child: Text('Rs')),
//                   ],
//                   onChanged: (value) => setState(() => isPercentageDiscount = value!),
//                 ),
//               ],
//             ),
//             Expanded(
//               flex: 1,
//               child: SingleChildScrollView(
//                 child: DataTable(
//                   headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade700),
//                   columns: const [
//                     DataColumn(label: Text('Item')),
//                     DataColumn(label: Text('Qty')),
//                     DataColumn(label: Text('Price')),
//                     DataColumn(label: Text('Total')),
//                     DataColumn(label: Text('Action')),
//                   ],
//                   rows: cartItems.asMap().entries.map((entry) {
//                     int index = entry.key;
//                     var item = entry.value;
//                     double unitPrice = item['price'];
//                     if (item['isItemDiscountPercentage'] == true) {
//                       unitPrice -= unitPrice * (item['itemDiscount'] ?? 0) / 100;
//                     } else {
//                       unitPrice -= item['itemDiscount'] ?? 0;
//                     }
//                     double totalPrice = unitPrice * item['quantity'];
//                     return DataRow(cells: [
//                       DataCell(Text(item['name'])),
//                       DataCell(Text('${item['quantity']}')),
//                       DataCell(Text('Rs. ${item['price']}')),
//                       DataCell(Text('Rs. ${totalPrice.toStringAsFixed(2)}')),
//                       DataCell(Row(
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.edit, size: 18),
//                             onPressed: () => _editCartItem(index),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.delete, size: 18),
//                             onPressed: () => setState(() => cartItems.removeAt(index)),
//                           ),
//                         ],
//                       )),
//                     ]);
//                   }).toList(),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: Text('Total: Rs. ${_calculateTotal().toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(bottom: 10),
//               child: Text(
//                 'Powered by AASA IT',
//                 style: TextStyle(color: Colors.white60, fontStyle: FontStyle.italic),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CategoryItemsPage extends StatelessWidget {
//   final String category;
//   final List<Map<String, dynamic>> items;
//   final void Function(Map<String, dynamic>) onItemSelected;

//   const CategoryItemsPage({
//     super.key,
//     required this.category,
//     required this.items,
//     required this.onItemSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData.dark(),
//       child: Scaffold(
//         appBar: AppBar(title: Text(category)),
//         body: GridView.count(
//           crossAxisCount: 2,
//           padding: const EdgeInsets.all(10),
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           children: items.map((item) {
//             final firstBatch = item['batches']?[0];
//             final price = firstBatch != null ? firstBatch['price'] : 'N/A';
//             return GestureDetector(
//               onTap: () => onItemSelected(item),
//               child: Card(
//                 color: Colors.tealAccent,
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(item['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                       Text('Rs. $price'),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class CashierViewPage extends StatefulWidget {
  const CashierViewPage({super.key});

  @override
  State<CashierViewPage> createState() => _CashierViewPageState();
}

class _CashierViewPageState extends State<CashierViewPage> {
  final List<String> categories = ['Drinks', 'Snacks', 'Grocery', 'Bakery'];

  final Map<String, List<Map<String, dynamic>>> itemsByCategory = {
    'Drinks': [
      {
        'name': 'Coke',
        'batches': [
          {'batchID': '123234', 'pprice': 120.00, 'price': 150.0, 'quantity': 20},
          {'batchID': '123237', 'pprice': 130.00, 'price': 160.0, 'quantity': 20},
        ]
      },
    ],
    'Snacks': [
      {
        'name': 'Chips',
        'batches': [
          {'batchID': '223234', 'pprice': 90.00, 'price': 100.0, 'quantity': 30},
        ],
      },
      {
        'name': 'Chocolate',
        'batches': [
          {'batchID': '223237', 'pprice': 100.00, 'price': 120.0, 'quantity': 25},
        ],
      },
    ],
    'Grocery': [
      {
        'name': 'Rice',
        'batches': [
          {'batchID': '323234', 'pprice': 80.00, 'price': 90.0, 'quantity': 50},
        ],
      },
      {
        'name': 'Sugar',
        'batches': [
          {'batchID': '323237', 'pprice': 60.00, 'price': 70.0, 'quantity': 40},
        ],
      },
    ],
    'Bakery': [
      {
        'name': 'Bread',
        'batches': [
          {'batchID': '423234', 'pprice': 70.00, 'price': 80.0, 'quantity': 15},
        ],
      },
      {
        'name': 'Bun',
        'batches': [
          {'batchID': '423237', 'pprice': 50.00, 'price': 60.0, 'quantity': 20},
        ],
      },
    ],
  };

  final List<Map<String, dynamic>> cartItems = [];
  String searchQuery = '';
  bool isPercentageDiscount = true;
  double discount = 0;

  void _addToCart(Map<String, dynamic> batch, {int quantity = 1}) {
    final existingIndex = cartItems.indexWhere(
      (i) => i['name'] == batch['name'] && i['batchID'] == batch['batchID'],
    );
    if (existingIndex >= 0) {
      cartItems[existingIndex]['quantity'] += quantity;
    } else {
      cartItems.add({
        'name': batch['name'],
        'price': batch['price'],
        'batchID': batch['batchID'],
        'quantity': quantity,
        'itemDiscount': 0.0,
        'isItemDiscountPercentage': false,
      });
    }
    setState(() {});
    Navigator.pop(context);  // Close the dialog
    Navigator.popUntil(context, (route) => route.isFirst); // Navigate back to the first screen
  }

  void _showBatchSelectionDialog(Map<String, dynamic> item) {
    final List<Map<String, dynamic>> batchList = List<Map<String, dynamic>>.from(item['batches'] ?? []);
    if (batchList.isEmpty) return;

    if (batchList.length == 1) {
      final selectedBatch = batchList[0];
      selectedBatch['name'] = item['name'];
      _showQuantityInputDialog(selectedBatch);
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Select Batch for ${item['name']}'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: batchList.length,
            itemBuilder: (context, index) {
              final batch = batchList[index];
              return ListTile(
                title: Text('Batch: ${batch['batchID']} - Price: Rs. ${batch['price']}'),
                onTap: () {
                  batch['name'] = item['name'];
                  Navigator.pop(context);
                  _showQuantityInputDialog(batch);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showQuantityInputDialog(Map<String, dynamic> batch) {
    int quantity = 1;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Enter quantity for ${batch['name']} (Batch: ${batch['batchID']})'),
        content: TextField(
          autofocus: true,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            quantity = int.tryParse(value) ?? 1;
          },
          onSubmitted: (value) {
            quantity = int.tryParse(value) ?? 1;
            Navigator.pop(context);
            _addToCart(batch, quantity: quantity);
          },
          decoration: const InputDecoration(hintText: 'Quantity'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _addToCart(batch, quantity: quantity);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editCartItem(int index) {
    int quantity = cartItems[index]['quantity'];
    double itemDiscount = cartItems[index]['itemDiscount'] ?? 0.0;
    bool isPercentage = cartItems[index]['isItemDiscountPercentage'] ?? false;

    final quantityController = TextEditingController(text: quantity.toString());
    final discountController = TextEditingController(text: itemDiscount.toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit ${cartItems[index]['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              controller: quantityController,
              onChanged: (value) => quantity = int.tryParse(value) ?? quantity,
            ),
            TextField(
              decoration: InputDecoration(labelText: isPercentage ? 'Discount (%)' : 'Discount (Rs)'),
              keyboardType: TextInputType.number,
              controller: discountController,
              onChanged: (value) => itemDiscount = double.tryParse(value) ?? itemDiscount,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Discount Type: '),
                DropdownButton<bool>(
                  value: isPercentage,
                  items: const [
                    DropdownMenuItem(value: true, child: Text('%')),
                    DropdownMenuItem(value: false, child: Text('Rs')),
                  ],
                  onChanged: (value) => setState(() => isPercentage = value!),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                if (quantity <= 0) {
                  cartItems.removeAt(index);
                } else {
                  cartItems[index]['quantity'] = quantity;
                  cartItems[index]['itemDiscount'] = itemDiscount;
                  cartItems[index]['isItemDiscountPercentage'] = isPercentage;
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  double _calculateTotal() {
    double total = 0;
    for (var item in cartItems) {
      double unitPrice = item['price'];
      double itemDiscount = item['itemDiscount'] ?? 0;
      if (item['isItemDiscountPercentage'] == true) {
        unitPrice -= unitPrice * itemDiscount / 100;
      } else {
        unitPrice -= itemDiscount;
      }
      total += unitPrice * item['quantity'];
    }
    return isPercentageDiscount
        ? total - (total * discount / 100)
        : total - discount;
  }

  @override
  Widget build(BuildContext context) {
    final searchedItems = itemsByCategory.entries
        .expand((entry) => entry.value)
        .where((item) => item['name'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cashier - Billing'),
          backgroundColor: const Color(0xFF0D1B2A),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) => setState(() => searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Search item or scan barcode...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            if (searchQuery.isEmpty) ...[
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: categories.map((cat) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryItemsPage(
                            category: cat,
                            items: itemsByCategory[cat]!,
                            onItemSelected: _showBatchSelectionDialog,
                          ),
                        ),
                      ),
                      child: Card(
                        color: Colors.blueGrey.shade200,
                        child: Center(child: Text(cat, style: const TextStyle(fontSize: 18))),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ] else ...[
              Expanded(
                child: ListView(
                  children: searchedItems.map((item) {
                    final firstBatch = item['batches'][0];
                    return ListTile(
                      title: Text(item['name']),
                      trailing: Text('Rs. ${firstBatch['price']}'),
                      onTap: () => _showBatchSelectionDialog(item),
                    );
                  }).toList(),
                ),
              )
            ],
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Bill Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Discount: "),
                SizedBox(
                  width: 80,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: '0'),
                    onChanged: (value) => setState(() => discount = double.tryParse(value) ?? 0),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<bool>(
                  value: isPercentageDiscount,
                  items: const [
                    DropdownMenuItem(value: true, child: Text('%')),
                    DropdownMenuItem(value: false, child: Text('Rs')),
                  ],
                  onChanged: (value) => setState(() => isPercentageDiscount = value!),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade700),
                  columns: const [
                    DataColumn(label: Text('Item')),
                    DataColumn(label: Text('Qty')),
                    DataColumn(label: Text('Price')),
                    DataColumn(label: Text('Total')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: cartItems.asMap().entries.map((entry) {
                    int index = entry.key;
                    var item = entry.value;
                    double unitPrice = item['price'];
                    double itemDiscount = item['itemDiscount'] ?? 0;
                    if (item['isItemDiscountPercentage'] == true) {
                      unitPrice -= unitPrice * itemDiscount / 100;
                    } else {
                      unitPrice -= itemDiscount;
                    }
                    double totalPrice = unitPrice * item['quantity'];
                    return DataRow(cells: [
                      DataCell(Text(item['name'])),
                      DataCell(Text('${item['quantity']}')),
                      DataCell(Text('Rs. ${item['price']}')),
                      DataCell(Text('Rs. ${totalPrice.toStringAsFixed(2)}')),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, size: 18),
                            onPressed: () => _editCartItem(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, size: 18),
                            onPressed: () => setState(() => cartItems.removeAt(index)),
                          ),
                        ],
                      )),
                    ]);
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text('Total: Rs. ${_calculateTotal().toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Powered by AASA IT',
                style: TextStyle(color: Colors.white60, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}

class CategoryItemsPage extends StatelessWidget {
  final String category;
  final List<Map<String, dynamic>> items;
  final void Function(Map<String, dynamic>) onItemSelected;

  const CategoryItemsPage({
    super.key,
    required this.category,
    required this.items,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(title: Text(category)),
        body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: items.map((item) {
            final firstBatch = item['batches']?[0];
            final price = firstBatch != null ? firstBatch['price'] : 'N/A';
            return GestureDetector(
              onTap: () => onItemSelected(item),
              child: Card(
                color: Colors.tealAccent,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('Rs. $price'),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
