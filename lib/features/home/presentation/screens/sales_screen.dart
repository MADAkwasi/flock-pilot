import 'package:flutter/material.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  final List<Map<String, dynamic>> sales = [];

  double get totalSales {
    return sales.fold(0, (sum, item) => sum + item['amount']);
  }

  void _addSale() {
    final amount = double.tryParse(amountController.text);

    if (amount == null || amount <= 0) return;

    setState(() {
      sales.insert(0, {
        'amount': amount,
        'description': descriptionController.text,
        'date': DateTime.now(),
      });

      amountController.clear();
      descriptionController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sales")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// ================= SUMMARY =================
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.green.withValues(alpha: 0.1),
            ),
            child: Text(
              "Total Sales: GHS ${totalSales.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),

          const SizedBox(height: 20),

          /// ================= FORM =================
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Amount",
              prefixIcon: Icon(Icons.attach_money),
            ),
          ),

          const SizedBox(height: 10),

          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: "Description",
              prefixIcon: Icon(Icons.description),
            ),
          ),

          const SizedBox(height: 10),

          ElevatedButton(onPressed: _addSale, child: const Text("Record Sale")),

          const SizedBox(height: 30),

          /// ================= HISTORY =================
          Text("Sales History", style: Theme.of(context).textTheme.titleMedium),

          const SizedBox(height: 10),

          ...sales.map((sale) {
            return Card(
              child: ListTile(
                leading: const Icon(Icons.trending_up, color: Colors.green),
                title: Text("GHS ${sale['amount']}"),
                subtitle: Text(sale['description'] ?? ''),
                trailing: Text(
                  "$sale['date'].toString().split('.')[0]",
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
