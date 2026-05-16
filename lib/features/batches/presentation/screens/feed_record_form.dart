import 'package:flock_pilot/shared/widgets/dropdown_field.dart';
import 'package:flock_pilot/shared/widgets/form_input_text_field.dart';
import 'package:flock_pilot/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedBatchScreen extends StatefulWidget {
  const FeedBatchScreen({super.key});

  @override
  State<FeedBatchScreen> createState() => _FeedBatchScreenState();
}

class _FeedBatchScreenState extends State<FeedBatchScreen> {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final batchTypeController = ValueNotifier<String?>(null);
  final feedTypeController = ValueNotifier<String?>(null);

  List<String> batches = ['Layer Batch A', 'Layer Batch B'];
  List<String> feed = [
    'Starter Mash',
    'Grower Mash',
    'Developer Mash',
    'Layer Mash',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feed Batch')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            DropdownField(
              options: batches,
              placeholder: 'Select batch',
              valueListenable: batchTypeController,
            ),

            const SizedBox(height: 20),

            DropdownField(
              options: feed,
              placeholder: 'Select feed',
              valueListenable: feedTypeController,
            ),

            const SizedBox(height: 10),

            FormInputTextField(
              label: 'Quantity (kg)',
              controller: quantityController,
              inputType: TextInputType.number,
              icon: FaIcon(FontAwesomeIcons.weightHanging),
            ),

            const SizedBox(height: 20),

            FormInputTextField(
              label: 'Notes',
              placeholder: 'Any relevant details',
              controller: notesController,
              maxLines: 4,
            ),

            const SizedBox(height: 30),

            PrimaryButton(label: 'Save Feed Usage', handlePress: () {}),
          ],
        ),
      ),
    );
  }
}
