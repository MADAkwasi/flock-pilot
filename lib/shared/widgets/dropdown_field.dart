import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final ValueNotifier<String?> valueListenable;
  final List<String> options;
  final String placeholder;

  const DropdownField({
    required this.valueListenable,
    required this.placeholder,
    required this.options,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          gapPadding: 0,
        ),
      ),
      hint: Text(placeholder, style: Theme.of(context).textTheme.labelLarge),
      items: options
          .map(
            (item) => DropdownItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14)),
            ),
          )
          .toList(),
      valueListenable: valueListenable,
      validator: (value) {
        if (value == null) {
          return placeholder;
        }
        return null;
      },
      onChanged: (value) {
        valueListenable.value = value;
      },
      iconStyleData: const IconStyleData(icon: Icon(Icons.arrow_drop_down)),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      ),
      menuItemStyleData: const MenuItemStyleData(
        useDecorationHorizontalPadding: true,
      ),
    );
  }
}
