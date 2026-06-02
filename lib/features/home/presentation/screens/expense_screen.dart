import 'package:flock_pilot/core/router/route_names.dart';
import 'package:flock_pilot/features/home/presentation/widgets/expense_card.dart';
import 'package:flock_pilot/provider/expense_provider.dart';
import 'package:flock_pilot/provider/farm_provider.dart';
import 'package:flock_pilot/shared/utils/toast.dart';
import 'package:flock_pilot/shared/widgets/dropdown_field.dart';
import 'package:flock_pilot/shared/widgets/form_input_text_field.dart';
import 'package:flock_pilot/shared/widgets/primary_button.dart';
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
  transportation,
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

  // ================= CLEAN PAYLOAD BUILDER =================
  Map<String, dynamic> _buildPayload() {
    final payload = <String, dynamic>{
      "type": selectedType.value?.toUpperCase(),
      "category": selectedCategory.value?.toUpperCase(),
      "amount": double.tryParse(amountController.text) ?? 0,
    };

    if ((selectedFlockId.value ?? "").isNotEmpty) {
      payload["flockId"] = selectedFlockId.value;
    }

    if ((selectedInventoryItemId.value ?? "").isNotEmpty) {
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
          _ExpenseForm(
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

class _ExpenseForm extends StatelessWidget {
  final ValueNotifier<String?> selectedType;
  final ValueNotifier<String?> selectedCategory;
  final ValueNotifier<String?> selectedFlockId;
  final ValueNotifier<String?> selectedInventoryItemId;

  final TextEditingController amountController;
  final TextEditingController quantityController;
  final TextEditingController descriptionController;

  final List<Map<String, String>> flocks;
  final List<Map<String, String>> inventoryItems;

  final bool isLoading;
  final VoidCallback onSubmit;

  const _ExpenseForm({
    required this.selectedType,
    required this.selectedCategory,
    required this.selectedFlockId,
    required this.selectedInventoryItemId,
    required this.amountController,
    required this.quantityController,
    required this.descriptionController,
    required this.flocks,
    required this.inventoryItems,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Record Expense", style: Theme.of(context).textTheme.titleMedium),

        const SizedBox(height: 15),

        DropdownField(
          valueListenable: selectedType,
          placeholder: "Expense Type",
          options: ExpenseType.values
              .map(
                (e) =>
                    '${e.name[0].toUpperCase()}${e.name.substring(1).toLowerCase()}',
              )
              .toList(),
        ),

        const SizedBox(height: 18),

        DropdownField(
          valueListenable: selectedCategory,
          placeholder: "Category",
          options: ExpenseCategory.values
              .map(
                (e) =>
                    '${e.name[0].toUpperCase()}${e.name.substring(1).toLowerCase()}',
              )
              .toList(),
        ),

        const SizedBox(height: 18),

        if (flocks.isNotEmpty)
          DropdownField(
            valueListenable: selectedFlockId,
            placeholder: "Flock (optional)",
            options: flocks,
          ),

        const SizedBox(height: 18),

        if (inventoryItems.isNotEmpty)
          DropdownField(
            valueListenable: selectedInventoryItemId,
            placeholder: "Inventory Item",
            options: inventoryItems,
          ),

        const SizedBox(height: 8),

        FormInputTextField(
          label: "Amount",
          controller: amountController,
          icon: const Icon(Icons.money),
          inputType: TextInputType.number,
        ),

        FormInputTextField(
          label: "Quantity",
          controller: quantityController,
          icon: const Icon(Icons.numbers),
        ),

        FormInputTextField(
          label: "Description",
          controller: descriptionController,
          icon: const Icon(Icons.note),
        ),

        const SizedBox(height: 20),

        PrimaryButton(
          label: "Record Expense",
          isLoading: isLoading,
          handlePress: isLoading ? null : onSubmit,
        ),
      ],
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
