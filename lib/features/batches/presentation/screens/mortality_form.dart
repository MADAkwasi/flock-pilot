import 'package:flock_pilot/shared/widgets/dropdown_field.dart';
import 'package:flock_pilot/shared/widgets/form_input_text_field.dart';
import 'package:flock_pilot/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MortalityScreen extends StatefulWidget {
  const MortalityScreen({super.key});

  @override
  State<MortalityScreen> createState() => _MortalityScreenState();
}

class _MortalityScreenState extends State<MortalityScreen> {
  final TextEditingController mortalityController = TextEditingController();
  final TextEditingController causeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final batchTypeController = ValueNotifier<String?>(null);

  List<String> batches = ['Layer Batch A', 'Layer Batch B'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record Mortality')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            DropdownField(
              options: batches,
              placeholder: 'Select batch',
              valueListenable: batchTypeController,
            ),

            const SizedBox(height: 10),

            FormInputTextField(
              label: 'Number of Mortalities',
              controller: mortalityController,
              inputType: TextInputType.number,
              icon: FaIcon(FontAwesomeIcons.triangleExclamation),
            ),

            const SizedBox(height: 10),

            FormInputTextField(
              label: 'Possible Cause',
              controller: causeController,
              icon: FaIcon(FontAwesomeIcons.virusCovid),
            ),

            const SizedBox(height: 10),

            FormInputTextField(
              label: 'Notes',
              placeholder: 'Any additional information',
              controller: notesController,
              maxLines: 4,
            ),

            const SizedBox(height: 30),

            PrimaryButton(
              label: 'Save Mortality Record',
              handlePress: () {},
              bgColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
