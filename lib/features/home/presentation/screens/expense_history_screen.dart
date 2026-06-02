import 'package:flock_pilot/features/home/presentation/widgets/expense_card.dart';
import 'package:flock_pilot/provider/farm_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ExpenseHistoryScreen extends ConsumerWidget {
  const ExpenseHistoryScreen({super.key});

  String _groupKey(DateTime date) {
    final now = DateTime.now();

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return "Today";
    }

    final yesterday = now.subtract(const Duration(days: 1));
    if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return "Yesterday";
    }

    return DateFormat('dd MMM yyyy').format(date);
  }

  double _total(List expenses) {
    return expenses.fold<double>(0, (sum, e) => sum + (e.amount ?? 0));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farm = ref.watch(farmProvider).farm;
    final expenses = farm?.expenses ?? [];
    final flocks =
        farm?.flocks.map((flock) => {"name": flock.name, "id": flock.id}) ?? [];
    final inventoryItems =
        farm?.inventoryItems.map(
          (item) => {"name": item.name, "id": item.id},
        ) ??
        [];

    /// GROUP EXPENSES
    final Map<String, List> grouped = {};

    for (final e in expenses) {
      final key = _groupKey(e.createdAt);
      grouped.putIfAbsent(key, () => []).add(e);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Expense History")),
      body: expenses.isEmpty
          ? const Center(child: Text("No expenses recorded"))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                /// ================= SUMMARY =================
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.red.withValues(alpha: 0.08),
                  ),
                  child: Text(
                    "Total Expenses: GHS ${_total(expenses).toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),

                const SizedBox(height: 20),

                /// ================= GROUPED LIST =================
                ...grouped.entries.map((entry) {
                  final dateLabel = entry.key;
                  final items = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// DATE HEADER
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          dateLabel,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),

                      /// ITEMS
                      ...items.map((expense) {
                        return ExpenseCard(
                          expense: expense,
                          flocks: flocks.toList(),
                          inventoryItems: inventoryItems.toList(),
                        );
                      }),
                    ],
                  );
                }),
              ],
            ),
    );
  }
}
