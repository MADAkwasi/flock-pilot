import 'package:flock_pilot/features/home/presentation/screens/expense_screen.dart';
import 'package:flock_pilot/shared/widgets/dropdown_field.dart';
import 'package:flock_pilot/shared/widgets/form_input_text_field.dart';
import 'package:flock_pilot/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class ExpenseForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final ValueNotifier<String?> selectedType;
  final ValueNotifier<String?> selectedCategory;
  final ValueNotifier<String?> selectedFlockId;
  final ValueNotifier<String?> selectedInventoryItemId;

  final TextEditingController amountController;
  final TextEditingController? quantityController;
  final TextEditingController descriptionController;

  final List<Map<String, String>> flocks;
  final List<Map<String, String>> inventoryItems;

  final bool isLoading;
  final VoidCallback onSubmit;

  const ExpenseForm({
    required this.formKey,
    required this.selectedType,
    required this.selectedCategory,
    required this.selectedFlockId,
    required this.selectedInventoryItemId,
    required this.amountController,
    required this.descriptionController,
    required this.flocks,
    required this.inventoryItems,
    required this.isLoading,
    required this.onSubmit,
    this.quantityController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Record Expense",
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 15),

          DropdownField(
            valueListenable: selectedType,
            placeholder: "Expense Type",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Expense type is required";
              }
              return null;
            },
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Expense category is required";
              }
              return null;
            },
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

          if (flocks.isNotEmpty) const SizedBox(height: 18),

          if (inventoryItems.isNotEmpty)
            DropdownField(
              valueListenable: selectedInventoryItemId,
              placeholder: 'Inventory Item (optional)',
              options: inventoryItems,
            ),

          const SizedBox(height: 8),

          FormInputTextField(
            label: "Amount",
            controller: amountController,
            icon: const Icon(Icons.money),
            inputType: TextInputType.number,

            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Amount is required";
              }

              final amount = double.tryParse(value);

              if (amount == null) {
                return "Enter a valid amount";
              }

              if (amount <= 0) {
                return "Amount must be greater than 0";
              }

              return null;
            },
          ),

          if (quantityController?.value != null)
            FormInputTextField(
              label: "Quantity",
              controller: quantityController!,
              icon: const Icon(Icons.numbers),
              inputType: TextInputType.number,

              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return null;
                }

                final quantity = double.tryParse(value);

                if (quantity == null) {
                  return "Enter a valid quantity";
                }

                if (quantity <= 0) {
                  return "Quantity must be greater than 0";
                }

                return null;
              },
            ),

          FormInputTextField(
            label: "Description",
            controller: descriptionController,
            icon: const Icon(Icons.note),

            validator: (value) {
              if (value != null && value.length > 300) {
                return "Description cannot exceed 300 characters";
              }

              return null;
            },
          ),

          const SizedBox(height: 20),

          PrimaryButton(
            label: "Record Expense",
            isLoading: isLoading,
            handlePress: isLoading ? null : onSubmit,
          ),
        ],
      ),
    );
  }
}
