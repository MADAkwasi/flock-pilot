import 'package:flock_pilot/core/theme/app_colors.dart';
import 'package:flock_pilot/shared/widgets/form_input_text_field.dart';
import 'package:flock_pilot/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class VaccinationScreen extends StatefulWidget {
  const VaccinationScreen({super.key});

  @override
  State<VaccinationScreen> createState() => _VaccinationScreenState();
}

class _VaccinationScreenState extends State<VaccinationScreen> {
  final TextEditingController vaccineController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule Vaccination')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            FormInputTextField(
              label: 'Vaccine Name',
              controller: vaccineController,
              icon: Icon(Icons.vaccines),
            ),

            const SizedBox(height: 20),

            ListTile(
              tileColor: Theme.of(context).colorScheme.surface,
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  width: 1,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkBorder
                      : AppColors.border,
                ),
              ),
              title: Text(
                'Vaccination Date',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              subtitle: Text(
                '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              trailing: const Icon(Icons.calendar_month),
              onTap: pickDate,
            ),

            const SizedBox(height: 20),

            FormInputTextField(
              label: 'Notes',
              placeholder: 'Add an relevant details',
              controller: notesController,
              maxLines: 4,
            ),

            const SizedBox(height: 30),

            PrimaryButton(label: 'Schedule Vaccination', handlePress: () {}),
          ],
        ),
      ),
    );
  }
}
