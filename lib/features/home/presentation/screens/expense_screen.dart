import 'package:flock_pilot/core/router/route_names.dart';
import 'package:flock_pilot/features/home/presentation/widgets/expense_card.dart';
import 'package:flock_pilot/features/home/presentation/widgets/expense_form.dart';
import 'package:flock_pilot/provider/expense_provider.dart';
import 'package:flock_pilot/provider/farm_provider.dart';
import 'package:flock_pilot/shared/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum ExpenseType { purchase, service, maintenance, loss, adjustment }

enum ExpenseCategory {
  feed,
  medication,
  inventory,
  labor,
  utilities,
  equipment,
  transport,
  maintenance,
  other,
}

class ExpenseScreen extends ConsumerStatefulWidget {
  const ExpenseScreen({super.key});

  @override
  ConsumerState<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends ConsumerState<ExpenseScreen> {
  final amountController = TextEditingController();
  final quantityController = TextEditingController();
  final descriptionController = TextEditingController();
  final _expenseFormKey = GlobalKey<FormState>();

  final selectedType = ValueNotifier<String?>(null);
  final selectedCategory = ValueNotifier<String?>(null);
  final selectedFlockId = ValueNotifier<String?>(null);
  final selectedInventoryItemId = ValueNotifier<String?>(null);

  @override
  void dispose() {
    amountController.dispose();
    quantityController.dispose();
    descriptionController.dispose();
    selectedType.dispose();
    selectedCategory.dispose();
    selectedFlockId.dispose();
    selectedInventoryItemId.dispose();
    super.dispose();
  }

  String? _normalize(ValueNotifier<String?> value) {
    return value.value?.trim().toUpperCase();
  }

  // ================= CLEAN PAYLOAD BUILDER =================
  Map<String, dynamic> _buildPayload() {
    final type = _normalize(selectedType);
    final category = _normalize(selectedCategory);

    final payload = <String, dynamic>{
      "type": type,
      "category": category,
      "amount": double.tryParse(amountController.text) ?? 0,
    };

    if (selectedFlockId.value?.isNotEmpty == true) {
      payload["flockId"] = selectedFlockId.value;
    }

    if (selectedInventoryItemId.value?.isNotEmpty == true) {
      payload["inventoryItemId"] = selectedInventoryItemId.value;
    }

    final quantity = double.tryParse(quantityController.text);
    if (quantity != null) {
      payload["quantity"] = quantity;
    }

    final description = descriptionController.text.trim();
    if (description.isNotEmpty) {
      payload["description"] = description;
    }

    return payload;
  }

  // ================= RESET FORM =================
  void _resetForm() {
    amountController.clear();
    quantityController.clear();
    descriptionController.clear();

    selectedType.value = null;
    selectedCategory.value = null;
    selectedFlockId.value = null;
    selectedInventoryItemId.value = null;
  }

  @override
  Widget build(BuildContext context) {
    final farm = ref.watch(farmProvider).farm;
    final expenseState = ref.watch(expenseControllerProvider);

    final expenses = [...(farm?.expenses ?? [])]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final flocks =
        farm?.flocks.map((f) => {"name": f.name, "id": f.id}).toList() ?? [];

    final inventoryItems =
        farm?.inventoryItems
            .map((i) => {"name": i.name, "id": i.id})
            .toList() ??
        [];

    final totalExpenses = expenses.fold<double>(
      0,
      (sum, e) => sum + (e.amount),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Expenses")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ================= SUMMARY =================
          _SummaryCard(total: totalExpenses),

          const SizedBox(height: 20),

          // ================= FORM =================
          ExpenseForm(
            formKey: _expenseFormKey,
            selectedType: selectedType,
            selectedCategory: selectedCategory,
            selectedFlockId: selectedFlockId,
            selectedInventoryItemId: selectedInventoryItemId,
            amountController: amountController,
            quantityController: quantityController,
            descriptionController: descriptionController,
            flocks: flocks,
            inventoryItems: inventoryItems,
            isLoading: expenseState.isLoading,
            onSubmit: () async {
              if (!_expenseFormKey.currentState!.validate()) {
                return;
              }

              final category = selectedCategory.value!.toUpperCase();

              if (category == "INVENTORY" &&
                  selectedInventoryItemId.value?.isNotEmpty != true) {
                ToastUtils.error(
                  context,
                  "Inventory item is required for inventory expenses",
                );
                return;
              }

              try {
                await ref
                    .read(expenseControllerProvider.notifier)
                    .createExpense(_buildPayload());

                if (!context.mounted) return;

                ToastUtils.success(context, "Expense recorded successfully");
                _resetForm();
              } catch (e) {
                if (!context.mounted) return;
                ToastUtils.error(context, e.toString());
              }
            },
          ),

          const SizedBox(height: 30),

          // ================= HISTORY =================
          _ExpenseHistory(
            expenses: expenses.take(5).toList(),
            flocks: flocks,
            inventoryItems: inventoryItems,
            onViewAll: () => context.push(RouteNames.expenseHistory),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final double total;

  const _SummaryCard({required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.red.withValues(alpha: 0.1),
      ),
      child: Text(
        "Total Expenses: GHS ${total.toStringAsFixed(2)}",
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class _ExpenseHistory extends StatelessWidget {
  final List expenses;
  final List<Map<String, String>> flocks;
  final List<Map<String, String>> inventoryItems;
  final VoidCallback onViewAll;

  const _ExpenseHistory({
    required this.expenses,
    required this.flocks,
    required this.inventoryItems,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Text("No expenses recorded");
    }

    return Column(
      children: [
        ...expenses.map(
          (e) => ExpenseCard(
            expense: e,
            flocks: flocks,
            inventoryItems: inventoryItems,
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: onViewAll,
          child: const Text("View full expense history"),
        ),
      ],
    );
  }
}
