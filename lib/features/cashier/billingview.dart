import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
          {
            'batchID': '123234',
            'pprice': 120.00,
            'price': 150.0,
            'quantity': 20,
          },
          {
            'batchID': '123237',
            'pprice': 130.00,
            'price': 160.0,
            'quantity': 20,
          },
        ],
      },
    ],
    'Snacks': [
      {
        'name': 'Chips',
        'batches': [
          {
            'batchID': '223234',
            'pprice': 90.00,
            'price': 100.0,
            'quantity': 30,
          },
        ],
      },
      {
        'name': 'Chocolate',
        'batches': [
          {
            'batchID': '223237',
            'pprice': 100.00,
            'price': 120.0,
            'quantity': 25,
          },
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

  void _showPaymentMethodDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Select Payment Method'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Card'),
              onTap: () {
                Navigator.pop(context);
                _printBill(paymentMethod: 'Card');
              },
            ),
            ListTile(
              title: const Text('Cash'),
              onTap: () {
                Navigator.pop(context);
                _showCashPaymentDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCashPaymentDialog() {
    double cashGiven = 0;
    final cashController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Enter Cash Amount'),
        content: TextField(
          autofocus: true,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          controller: cashController,
          decoration: const InputDecoration(hintText: 'Enter cash amount'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              cashGiven = double.tryParse(cashController.text) ?? 0;
              double total = _calculateTotal();

              if (cashGiven < total) {
                // Show error if cash given is less than total
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cash amount is less than total'),
                  ),
                );
                return;
              }

              Navigator.pop(context);

              double balance = cashGiven - total;
              _printBill(
                paymentMethod: 'Cash',
                cashGiven: cashGiven,
                balance: balance,
              );
            },
            child: const Text('Pay'),
          ),
        ],
      ),
    );
  }

  void _printBill({
    required String paymentMethod,
    double cashGiven = 0,
    double balance = 0,
  }) {
    final now = DateTime.now();
    final formattedDateTime = DateFormat('yyyy-MM-dd – hh:mm a').format(now);

    StringBuffer bill = StringBuffer();
    bill.writeln('------- AASA POS BILL -------\n');
    bill.writeln('Date: $formattedDateTime');
    bill.writeln('------------------------------');
    bill.writeln('Items:');
    bill.writeln('------------------------------');

    for (var item in cartItems) {
      String name = item['name'];
      int qty = item['quantity'];
      double price = item['price'];
      double itemDiscount = item['itemDiscount'] ?? 0.0;
      bool isPercentage = item['isItemDiscountPercentage'] ?? false;

      double finalUnitPrice = price;
      if (isPercentage) {
        finalUnitPrice -= price * itemDiscount / 100;
      } else {
        finalUnitPrice -= itemDiscount;
      }

      double total = finalUnitPrice * qty;

      bill.writeln('$name\n  Qty: $qty x Rs. ${price.toStringAsFixed(2)}');
      if (itemDiscount > 0) {
        bill.writeln(
          '  Discount: ${itemDiscount.toStringAsFixed(2)} ${isPercentage ? "%" : "Rs"}',
        );
      }
      bill.writeln('  Final Price: Rs. ${finalUnitPrice.toStringAsFixed(2)}');
      bill.writeln('  Line Total: Rs. ${total.toStringAsFixed(2)}\n');
    }

    bill.writeln('------------------------------');
    bill.writeln('Subtotal: Rs. ${_calculateTotal().toStringAsFixed(2)}');

    if (discount > 0) {
      String discountText = isPercentageDiscount
          ? '$discount%'
          : 'Rs. ${discount.toStringAsFixed(2)}';
      bill.writeln('Overall Discount: $discountText');
    }

    bill.writeln('Payment Method: $paymentMethod');
    if (paymentMethod == 'Cash') {
      bill.writeln('Cash Given: Rs. ${cashGiven.toStringAsFixed(2)}');
      bill.writeln('Balance: Rs. ${balance.toStringAsFixed(2)}');
    }

    bill.writeln('\nThank you for shopping with us!');
    bill.writeln('------------------------------');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Bill Printed'),
        content: SingleChildScrollView(child: Text(bill.toString())),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                cartItems.clear();
                discount = 0;
                searchQuery = '';
              });
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  void _addToCart(
    Map<String, dynamic> batch, {
    int quantity = 1,
    bool fromSearch = false,
  }) {
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
    setState(() {
      if (fromSearch) {
        searchQuery = ''; // ✅ clear search bar
      }
    });

    if (!fromSearch) {
      Navigator.popUntil(
        context,
        (route) => route.isFirst,
      ); // ✅ go back to billing view
    }
  }

  void _showBatchSelectionDialog(
    Map<String, dynamic> item, {
    bool fromSearch = false,
  }) {
    final List<Map<String, dynamic>> batchList =
        List<Map<String, dynamic>>.from(item['batches'] ?? []);
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
                title: Text(
                  'Batch: ${batch['batchID']} - Price: Rs. ${batch['price']}',
                ),
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
        title: Text(
          'Enter quantity for ${batch['name']} (Batch: ${batch['batchID']})',
        ),
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
    final discountController = TextEditingController(
      text: itemDiscount.toString(),
    );

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
              decoration: InputDecoration(
                labelText: isPercentage ? 'Discount (%)' : 'Discount (Rs)',
              ),
              keyboardType: TextInputType.number,
              controller: discountController,
              onChanged: (value) =>
                  itemDiscount = double.tryParse(value) ?? itemDiscount,
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
        .where(
          (item) =>
              item['name'].toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();

    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Removes back button
          backgroundColor: const Color(0xFF0D1B2A),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Cashier'),
              Text(
                'John Doe', // <-- Replace with actual cashier name if dynamic
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            if (searchQuery.isEmpty) ...[
              Expanded(
                child: GridView.count(
                  crossAxisCount: 6,
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
                        color: const Color.fromARGB(255, 216, 12, 12),
                        child: Center(
                          child: Text(cat, style: const TextStyle(fontSize: 1)),
                        ),
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
                      onTap: () =>
                          _showBatchSelectionDialog(item, fromSearch: true),
                    );
                  }).toList(),
                ),
              ),
            ],
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Bill Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
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
                    onChanged: (value) =>
                        setState(() => discount = double.tryParse(value) ?? 0),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<bool>(
                  value: isPercentageDiscount,
                  items: const [
                    DropdownMenuItem(value: true, child: Text('%')),
                    DropdownMenuItem(value: false, child: Text('Rs')),
                  ],
                  onChanged: (value) =>
                      setState(() => isPercentageDiscount = value!),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.grey.shade700,
                  ),
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
                    return DataRow(
                      cells: [
                        DataCell(Text(item['name'])),
                        DataCell(Text('${item['quantity']}')),
                        DataCell(Text('Rs. ${item['price']}')),
                        DataCell(Text('Rs. ${totalPrice.toStringAsFixed(2)}')),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, size: 18),
                                onPressed: () => _editCartItem(index),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, size: 18),
                                onPressed: () =>
                                    setState(() => cartItems.removeAt(index)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Total: Rs. ${_calculateTotal().toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // New Pay button here:
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: cartItems.isEmpty ? null : _showPaymentMethodDialog,
                child: const Text('Pay'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 40),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Powered by AASA IT',
                style: TextStyle(
                  color: Colors.white60,
                  fontStyle: FontStyle.italic,
                ),
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
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
