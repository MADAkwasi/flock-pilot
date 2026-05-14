import 'package:flock_pilot/core/theme/app_colors.dart';
import 'package:flock_pilot/features/batches/presentation/widgets/batch_card.dart';
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

  Widget _miniStat(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.secondary
                      : AppColors.primary,

                  borderRadius: BorderRadius.circular(24),

                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ================= TOP SECTION =================
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // LEFT TEXT
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Birds',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: Colors.white.withValues(
                                        alpha: 0.8,
                                      ),
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                '1,230',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -1,
                                    ),
                              ),
                            ],
                          ),
                        ),

                        // RIGHT PLACEHOLDER (for chart)
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.pie_chart_outline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // ================= BOTTOM STATS =================
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(16),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _miniStat(context, 'Broilers', '600'),
                          _miniStat(context, 'Layers', '630'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

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
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
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
      ),
    );
  }
}

final List<Map<String, dynamic>> batchData = [
  {
    "batchId": "B001",
    "batchName": "Layer Batch A",
    "type": 'layer',
    "status": "Active",
    "birds": 120,
    "ageWeeks": 12,
    "feedPerDay": 18.5,
    "eggsPerDay": 95,
    "mortality": 2,
    "healthScore": 92,
    "startDate": "2025-10-01",
  },
  {
    "batchId": "B002",
    "batchName": "Broiler Batch B",
    "type": 'broiler',
    "status": "Active",
    "birds": 80,
    "ageWeeks": 6,
    "feedPerDay": 14.2,
    "eggsPerDay": 0,
    "mortality": 1,
    "healthScore": 88,
    "startDate": "2025-11-10",
  },
  {
    "batchId": "B003",
    "batchName": "Layer Batch C",
    "type": 'layer',
    "status": "Monitoring",
    "birds": 150,
    "ageWeeks": 18,
    "feedPerDay": 22.0,
    "eggsPerDay": 110,
    "mortality": 3,
    "healthScore": 85,
    "startDate": "2025-08-15",
  },
  {
    "batchId": "B004",
    "batchName": "Starter Batch D",
    "type": 'broiler',
    "status": "Active",
    "birds": 200,
    "ageWeeks": 4,
    "feedPerDay": 16.8,
    "eggsPerDay": 0,
    "mortality": 0,
    "healthScore": 96,
    "startDate": "2025-12-01",
  },
  {
    "batchId": "B005",
    "batchName": "Layer Batch E",
    "type": 'layer',
    "status": "Critical",
    "birds": 90,
    "ageWeeks": 20,
    "feedPerDay": 20.1,
    "eggsPerDay": 70,
    "mortality": 6,
    "healthScore": 60,
    "startDate": "2025-07-20",
  },
  {
    "batchId": "B006",
    "batchName": "Broiler Batch F",
    "type": 'broiler',
    "status": "Active",
    "birds": 110,
    "ageWeeks": 8,
    "feedPerDay": 17.3,
    "eggsPerDay": 0,
    "mortality": 1,
    "healthScore": 90,
    "startDate": "2025-11-25",
  },
];

// enum BirdType { layer, broiler }




// Container(
//                         child: Row(
//                           children: [
//                             IconTheme(
//                               data: IconThemeData(
//                                 color: batch["type"] == BirdType.broiler
//                                     ? Color(0xFF2B7FFF)
//                                     : Color(0xFFC14D00),
//                                 size: 26,
//                               ),

//                               child: batch["type"] == BirdType.broiler
//                                   ? FaIcon(FontAwesomeIcons.kiwiBird)
//                                   : FaIcon(FontAwesomeIcons.egg),
//                             ),

//                             Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       batch["batchName"],
//                                       style: Theme.of(
//                                         context,
//                                       ).textTheme.headlineMedium,
//                                     ),
//                                     Text(
//                                       batch['type'] == BirdType.broiler
//                                           ? 'Broiler'
//                                           : 'Layer',
//                                       style: Theme.of(
//                                         context,
//                                       ).textTheme.labelMedium,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),