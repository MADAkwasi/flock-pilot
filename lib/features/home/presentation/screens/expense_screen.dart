import 'package:flock_pilot/core/router/route_names.dart';
import 'package:flock_pilot/features/home/presentation/widgets/expense_card.dart';
import 'package:flock_pilot/provider/farm_provider.dart';
import 'package:flock_pilot/shared/widgets/dropdown_field.dart';
import 'package:flock_pilot/shared/widgets/form_input_text_field.dart';
import 'package:flock_pilot/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

enum ExpenseType { purchase, service, maintenance, loss, adjustment }

enum ExpenseCategory {
  feed,
  medication,
  labor,
  inventory,
  transport,
  utilities,
  equipment,
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
    super.dispose();
  }

  double _calculateTotal(List expenses) {
    return expenses.fold<double>(0.0, (sum, item) => sum + (item.amount ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    final farm = ref.watch(farmProvider).farm;

    final expenses = farm?.expenses ?? [];
    final flocks =
        farm?.flocks.map((flock) => {"name": flock.name, "id": flock.id}) ?? [];
    final inventoryItems =
        farm?.inventoryItems.map(
          (item) => {"name": item.name, "id": item.id},
        ) ??
        [];

    final totalExpenses = _calculateTotal(expenses);

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

          /// ================= FORM (UI ONLY FOR NOW) =================
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Record Expense",
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: 15),

              /// TYPE
              DropdownField(
                valueListenable: selectedType,
                placeholder: "Expense Type",
                options: ExpenseType.values
                    .map(
                      (type) =>
                          '${type.name[0].toUpperCase()}${type.name.substring(1)}',
                    )
                    .toList(),
              ),

              const SizedBox(height: 16),

              DropdownField(
                valueListenable: selectedCategory,
                placeholder: "Category",
                options: ExpenseCategory.values
                    .map(
                      (cat) =>
                          '${cat.name[0].toUpperCase()}${cat.name.substring(1)}',
                    )
                    .toList(),
              ),

              const SizedBox(height: 16),

              if (flocks.isNotEmpty)
                DropdownField(
                  valueListenable: selectedFlockId,
                  placeholder: "Flock (optional)",
                  options: flocks.toList(),
                ),

              if (flocks.isNotEmpty) const SizedBox(height: 16),

              if (inventoryItems.isNotEmpty)
                DropdownField(
                  valueListenable: selectedInventoryItemId,
                  placeholder: "Inventory Item (optional)",
                  options: inventoryItems.toList(),
                ),

              if (inventoryItems.isNotEmpty) const SizedBox(height: 10),

              /// AMOUNT
              FormInputTextField(
                label: "Amount",
                controller: amountController,
                icon: FaIcon(FontAwesomeIcons.moneyBill),
                inputType: TextInputType.number,
              ),

              /// QUANTITY (optional)
              FormInputTextField(
                label: "Quantity (optional)",
                controller: quantityController,
                icon: Icon(Icons.onetwothree),
                inputType: TextInputType.number,
              ),

              /// DESCRIPTION
              FormInputTextField(
                label: "Description (optional)",
                controller: descriptionController,
                icon: FaIcon(FontAwesomeIcons.noteSticky),
                inputType: TextInputType.multiline,
              ),

              const SizedBox(height: 20),

              /// SUBMIT BUTTON
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  label: "Record Expense",
                  handlePress: () {
                    final payload = {
                      "flockId": selectedFlockId.value,
                      "inventoryItemId": selectedInventoryItemId.value,
                      "type": selectedType.value,
                      "category": selectedCategory.value,
                      "amount": double.tryParse(amountController.text) ?? 0,
                      "quantity": quantityController.text.isEmpty
                          ? null
                          : double.tryParse(quantityController.text),
                      "description": descriptionController.text.isEmpty
                          ? null
                          : descriptionController.text,
                    };

                    debugPrint(payload.toString());

                    // TODO: send to API
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          /// ================= HISTORY =================
          Text(
            "Recent Expenses",
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 10),

          Builder(
            builder: (_) {
              final recentExpenses = expenses.take(5).toList();

              if (recentExpenses.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("No expenses recorded"),
                );
              }

              return Column(
                children: [
                  ...recentExpenses.map((expense) {
                    return ExpenseCard(
                      expense: expense,
                      inventoryItems: inventoryItems.toList(),
                      flocks: flocks.toList(),
                    );
                  }),

                  const SizedBox(height: 10),

                  TextButton(
                    onPressed: () {
                      context.push(RouteNames.expenseHistory);
                    },
                    child: const Text("View full expense history"),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
