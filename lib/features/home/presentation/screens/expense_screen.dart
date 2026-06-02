import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final amountController = TextEditingController();
  final categoryController = TextEditingController();

  final List<Map<String, dynamic>> expenses = [];

  double get totalExpenses {
    return expenses.fold(0, (sum, item) => sum + item['amount']);
  }

  void _addExpense() {
    final amount = double.tryParse(amountController.text);

    if (amount == null || amount <= 0) return;

    setState(() {
      expenses.insert(0, {
        'amount': amount,
        'category': categoryController.text,
        'date': DateTime.now(),
      });

      amountController.clear();
      categoryController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expenses")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// ================= SUMMARY =================
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.red.withValues(alpha: 0.1),
            ),
            child: Text(
              "Total Expenses: GHS ${totalExpenses.toStringAsFixed(2)}",
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
              prefixIcon: Icon(Icons.money_off),
            ),
          ),

          const SizedBox(height: 10),

          TextField(
            controller: categoryController,
            decoration: const InputDecoration(
              labelText: "Category (Feed, Vaccine, Transport...)",
              prefixIcon: Icon(Icons.category),
            ),
          ),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: _addExpense,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Record Expense"),
          ),

          const SizedBox(height: 30),

          /// ================= HISTORY =================
          Text(
            "Expense History",
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 10),

          ...expenses.map((expense) {
            return Card(
              child: ListTile(
                leading: const Icon(Icons.trending_down, color: Colors.red),
                title: Text("GHS ${expense['amount']}"),
                subtitle: Text(expense['category'] ?? ''),
                trailing: Text(
                  "$expense['date'].toString().split('.')[0]",
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
