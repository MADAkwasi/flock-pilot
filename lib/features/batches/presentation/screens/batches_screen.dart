import 'package:flock_pilot/core/constants/app_constants.dart';
import 'package:flock_pilot/features/batches/presentation/widgets/batch_card.dart';
import 'package:flock_pilot/features/batches/presentation/widgets/heading_card.dart';
import 'package:flock_pilot/shared/widgets/form_input_text_field.dart';
import 'package:flock_pilot/shared/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BatchesScreen extends StatefulWidget {
  const BatchesScreen({super.key});

  @override
  State<BatchesScreen> createState() => _BatchesScreenState();
}

class _BatchesScreenState extends State<BatchesScreen> {
  final List<String> filters = ['All', 'Layers', 'Broilers'];
  late String selectedFilter;

  final TextEditingController searchController = TextEditingController();

  List filteredBatches() {
    if (selectedFilter == 'All') return batchData;

    return batchData
        .where(
          (batch) =>
              batch["type"].toString().toLowerCase() ==
              selectedFilter.replaceFirst('s', '').toLowerCase(),
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();

    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(height: 10),

            Text(
              'Batch Management',
              style: Theme.of(context).textTheme.headlineLarge,
            ),

            SizedBox(height: 15),

            HeadingCard(),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                children: [
                  FormInputTextField(
                    placeholder: 'Search batches...',
                    controller: searchController,
                    icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
                  ),

                  Row(
                    children: filters
                        .map(
                          (filter) => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedFilter = filter;
                                });
                              },
                              style: selectedFilter == filter
                                  ? TextButton.styleFrom(
                                      backgroundColor: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      foregroundColor: Colors.white,
                                      elevation: 10,
                                    )
                                  : TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        side: BorderSide(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                      ),
                                    ),
                              child: Text(filter),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),

            Column(
              children: filteredBatches()
                  .map((batch) => BatchCard(batch: batch, onTap: () {}))
                  .toList(),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SecondaryButton(
                label: 'Add New Batch',
                handlePress: () {},
                icon: FaIcon(FontAwesomeIcons.plus),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
