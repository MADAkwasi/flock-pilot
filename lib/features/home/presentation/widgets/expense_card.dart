import 'package:flock_pilot/features/home/presentation/screens/expense_screen.dart';
import 'package:flock_pilot/shared/models/expense_model.dart';
import 'package:flock_pilot/shared/widgets/dropdown_field.dart';
import 'package:flock_pilot/shared/widgets/form_input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpenseCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.trending_down, color: Colors.red),

        title: Text(
          "GHS ${expense.amount.toStringAsFixed(2)}",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),

            Text(expense.category),

            if (expense.description != null && expense.description!.isNotEmpty)
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
          onSelected: (value) async {
            if (value == 'edit') {
              _showEditExpenseSheet(context, expense, flocks, inventoryItems);
            }

            if (value == 'delete') {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text("Delete Expense"),
                    content: const Text(
                      "Are you sure you want to delete this expense?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text("Cancel"),
                      ),

                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text("Delete"),
                      ),
                    ],
                  );
                },
              );

              if (confirm == true) {
                // TODO:
                // call delete API
                // invalidate provider
              }
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
}

void _showEditExpenseSheet(
  BuildContext context,
  dynamic expense,
  dynamic flocks,
  dynamic inventoryItems,
) {
  final amountController = TextEditingController(
    text: expense.amount.toStringAsFixed(2),
  );

  final descriptionController = TextEditingController(
    text: expense.description ?? '',
  );

  // final quantityController = TextEditingController(
  //   text: expense.quantity != null ? expense.quantity.toString() : '',
  // );

  final selectedFlock = ValueNotifier<String?>(
    flocks.firstWhere(
      (f) => f['id'] == expense.flockId,
      orElse: () => const {'id': '', 'name': ''},
    )['name'],
  );

  final selectedInventoryItem = ValueNotifier<String?>(
    inventoryItems.firstWhere(
      (i) => i['id'] == expense.inventoryItemId,
      orElse: () => const {'id': '', 'name': ''},
    )['name'],
  );

  final selectedType = ValueNotifier<String?>(
    expense.type != null
        ? '${expense.type[0].toUpperCase()}${expense.type.substring(1).toLowerCase()}'
        : null,
  );

  final selectedCategory = ValueNotifier<String?>(
    expense.category != null
        ? '${expense.category[0].toUpperCase()}${expense.category.substring(1).toLowerCase()}'
        : null,
  );

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,

    builder: (_) {
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
                valueListenable: selectedFlock,
                placeholder: "Flock (optional)",
                options: flocks.map((flock) => flock['name'] ?? '').toList(),
              ),

            if (flocks.isNotEmpty) const SizedBox(height: 16),

            if (inventoryItems.isNotEmpty)
              DropdownField(
                valueListenable: selectedInventoryItem,
                placeholder: "Inventory Item (optional)",
                options: inventoryItems
                    .map((item) => item['name'] ?? '')
                    .toList(),
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
            // FormInputTextField(
            //   label: "Quantity (optional)",
            //   controller: quantityController,
            //   icon: Icon(Icons.onetwothree),
            //   inputType: TextInputType.number,
            // ),

            /// DESCRIPTION
            FormInputTextField(
              label: "Description (optional)",
              controller: descriptionController,
              icon: FaIcon(FontAwesomeIcons.noteSticky),
              inputType: TextInputType.multiline,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  // TODO:
                  // update expense API call

                  Navigator.pop(context);
                },

                child: const Text("Save Changes"),
              ),
            ),
          ],
        ),
      );
    },
  );
}
