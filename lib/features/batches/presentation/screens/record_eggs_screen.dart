import 'package:flock_pilot/shared/widgets/dropdown_field.dart';
import 'package:flock_pilot/shared/widgets/form_input_text_field.dart';
import 'package:flock_pilot/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecordEggsScreen extends StatefulWidget {
  const RecordEggsScreen({super.key});

  @override
  State<RecordEggsScreen> createState() => _RecordEggsScreenState();
}

class _RecordEggsScreenState extends State<RecordEggsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController traysController = TextEditingController();
  final TextEditingController brokenEggsController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final batchTypeController = ValueNotifier<String?>(null);

  List<String> batches = ['Layer Batch A', 'Layer Batch B'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record Eggs')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownField(
                options: batches,
                placeholder: 'Select batch',
                valueListenable: batchTypeController,
              ),

              const SizedBox(height: 17),

              FormInputTextField(
                label: 'Eggs Collected',
                controller: traysController,
                inputType: TextInputType.number,
                icon: FaIcon(FontAwesomeIcons.egg),
              ),

              const SizedBox(height: 10),

              FormInputTextField(
                label: 'Broken Eggs',
                controller: brokenEggsController,
                inputType: TextInputType.number,
                icon: FaIcon(FontAwesomeIcons.triangleExclamation),
              ),

              const SizedBox(height: 10),

              FormInputTextField(
                label: 'Notes',
                placeholder:
                    'e.g. unusual behavior, feed issues, or health observations',
                controller: notesController,
                maxLines: 4,
              ),

              const SizedBox(height: 30),

              PrimaryButton(label: 'Save Record', handlePress: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
