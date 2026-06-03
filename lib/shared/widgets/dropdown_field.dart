import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final ValueNotifier<String?> valueListenable;
  final List<dynamic> options;
  final String placeholder;
  final String? Function(String?)? validator;

  const DropdownField({
    required this.valueListenable,
    required this.placeholder,
    required this.options,
    this.validator,
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

      items: options.map((item) {
        final isMap = item is Map;

        final value = isMap ? item['id'].toString() : item.toString();

        final label = isMap ? item['name'].toString() : item.toString();

        return DropdownItem<String>(
          value: value,
          child: Text(label, style: const TextStyle(fontSize: 14)),
        );
      }).toList(),

      valueListenable: valueListenable,

      validator: validator,

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
