import 'package:flock_pilot/features/home/presentation/screens/expense_screen.dart';
import 'package:flock_pilot/provider/expense_provider.dart';
import 'package:flock_pilot/shared/models/expense_model.dart';
import 'package:flock_pilot/shared/utils/toast.dart';
import 'package:flock_pilot/shared/widgets/dropdown_field.dart';
import 'package:flock_pilot/shared/widgets/form_input_text_field.dart';
import 'package:flock_pilot/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseCard extends ConsumerWidget {
  const ExpenseCard({
    required this.expense,
    required this.flocks,
    required this.inventoryItems,
    super.key,
  });

  final ExpenseModel expense;
  final List<Map<String, String>> flocks;
  final List<Map<String, String>> inventoryItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.trending_down, color: Colors.red),

        title: Text(
          "GHS ${expense.amount.toStringAsFixed(2)}",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(expense.category),

            if (expense.description?.isNotEmpty == true)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  expense.description!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ),
          ],
        ),

        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                _showEditExpenseSheet(
                  context: context,
                  ref: ref,
                  expense: expense,
                  flocks: flocks,
                  inventoryItems: inventoryItems,
                );
                break;

              case 'delete':
                _confirmDelete(context, ref);
                break;
            }
          },

          itemBuilder: (_) => const [
            PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [Icon(Icons.edit), SizedBox(width: 10), Text("Edit")],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 10),
                  Text("Delete", style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),

        isThreeLine: true,
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Expense"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await ref
          .read(expenseControllerProvider.notifier)
          .deleteExpense(expense.id);

      if (!context.mounted) return;
      ToastUtils.success(context, "Expense deleted");
    } catch (e) {
      if (!context.mounted) return;
      ToastUtils.error(context, e.toString());
    }
  }
}

void _showEditExpenseSheet({
  required BuildContext context,
  required WidgetRef ref,
  required ExpenseModel expense,
  required List<Map<String, String>> flocks,
  required List<Map<String, String>> inventoryItems,
}) {
  // ---------------- CONTROLLERS ----------------
  final amountController = TextEditingController(
    text: expense.amount.toStringAsFixed(2),
  );

  final descriptionController = TextEditingController(
    text: expense.description ?? '',
  );

  // ---------------- MAPS (ID <-> NAME) ----------------
  final flockIdToName = {for (final f in flocks) f['id']!: f['name']!};

  final flockNameToId = {for (final f in flocks) f['name']!: f['id']!};

  final inventoryIdToName = {
    for (final i in inventoryItems) i['id']!: i['name']!,
  };

  final inventoryNameToId = {
    for (final i in inventoryItems) i['name']!: i['id']!,
  };

  // ---------------- OPTIONS (DISPLAY ONLY) ----------------
  final typeOptions = ExpenseType.values
      .map((e) => e.name.toUpperCase())
      .toList();
  final categoryOptions = ExpenseCategory.values
      .map((e) => e.name.toUpperCase())
      .toList();

  final flockOptions = flocks.map((f) => f['name']!).toList();
  final inventoryOptions = inventoryItems.map((i) => i['name']!).toList();

  // ---------------- SAFE INIT ----------------
  String? safe(String? value, List<String> options) {
    if (value == null) return null;
    return options.contains(value) ? value : null;
  }

  final selectedType = ValueNotifier<String?>(safe(expense.type, typeOptions));

  final selectedCategory = ValueNotifier<String?>(
    safe(expense.category, categoryOptions),
  );

  // IMPORTANT: convert ID → NAME for UI
  final selectedFlockName = ValueNotifier<String?>(
    flockIdToName[expense.flockId],
  );

  final selectedInventoryName = ValueNotifier<String?>(
    inventoryIdToName[expense.inventoryItemId],
  );

  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    selectedType.dispose();
    selectedCategory.dispose();
    selectedFlockName.dispose();
    selectedInventoryName.dispose();
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      final expenseState = ref.watch(expenseControllerProvider);

      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Edit Expense", style: Theme.of(context).textTheme.titleLarge),

            const SizedBox(height: 20),

            // ---------------- TYPE ----------------
            DropdownField(
              valueListenable: selectedType,
              placeholder: "Expense Type",
              options: typeOptions,
            ),

            const SizedBox(height: 16),

            // ---------------- CATEGORY ----------------
            DropdownField(
              valueListenable: selectedCategory,
              placeholder: "Category",
              options: categoryOptions,
            ),

            const SizedBox(height: 16),

            // ---------------- FLOCK (NAME UI, ID SUBMIT) ----------------
            if (flockOptions.isNotEmpty)
              DropdownField(
                valueListenable: selectedFlockName,
                placeholder: "Flock (optional)",
                options: flockOptions,
              ),

            const SizedBox(height: 16),

            // ---------------- INVENTORY ----------------
            if (inventoryOptions.isNotEmpty)
              DropdownField(
                valueListenable: selectedInventoryName,
                placeholder: "Inventory Item (optional)",
                options: inventoryOptions,
              ),

            // ---------------- AMOUNT ----------------
            FormInputTextField(
              controller: amountController,
              inputType: TextInputType.number,
              label: "Amount",
            ),

            // ---------------- DESCRIPTION ----------------
            FormInputTextField(
              controller: descriptionController,
              label: "Description (optional)",
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                label: "Save Changes",
                isLoading: expenseState.isLoading,
                handlePress: () async {
                  final payload = <String, dynamic>{
                    "type": selectedType.value,
                    "category": selectedCategory.value,
                    "amount":
                        double.tryParse(amountController.text.trim()) ?? 0,
                  };

                  final flockId = selectedFlockName.value != null
                      ? flockNameToId[selectedFlockName.value]
                      : null;

                  if (flockId != null && flockId.isNotEmpty) {
                    payload["flockId"] = flockId;
                  }

                  final inventoryItemId = selectedInventoryName.value != null
                      ? inventoryNameToId[selectedInventoryName.value]
                      : null;

                  if (inventoryItemId != null && inventoryItemId.isNotEmpty) {
                    payload["inventoryItemId"] = inventoryItemId;
                  }

                  final description = descriptionController.text.trim();
                  if (description.isNotEmpty) {
                    payload["description"] = description;
                  }

                  try {
                    await ref
                        .read(expenseControllerProvider.notifier)
                        .updateExpense(expenseId: expense.id, payload: payload);

                    if (!context.mounted) return;

                    ToastUtils.success(context, "Expense updated");
                    Navigator.pop(context);
                  } catch (e) {
                    if (!context.mounted) return;

                    ToastUtils.error(context, "Edit failed");
                  }
                },
              ),
            ),
          ],
        ),
      );
    },
  ).whenComplete(dispose);
}
