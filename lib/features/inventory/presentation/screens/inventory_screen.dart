import 'package:flock_pilot/shared/widgets/form_input_text_field.dart';
import 'package:flock_pilot/shared/widgets/primary_button.dart';
import 'package:flock_pilot/shared/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> feedInventory = [
    {
      'feedName': 'Starter Mash',
      'batch': 'Broiler Batch B',
      'remainingKg': 240,
      'usagePerDay': 48,
      'stockPercentage': 24,
    },
    {
      'feedName': 'Layer Concentrate',
      'batch': 'Layer Batch A',
      'remainingKg': 760,
      'usagePerDay': 62,
      'stockPercentage': 78,
    },
    {
      'feedName': 'Grower Feed',
      'batch': 'Starter Batch D',
      'remainingKg': 530,
      'usagePerDay': 38,
      'stockPercentage': 54,
    },
  ];

  @override
  void initState() {
    super.initState();

    // ✅ FIX: ensures UI rebuilds when typing
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Color _stockColor(int percent) {
    if (percent >= 60) return Colors.green;
    if (percent >= 30) return Colors.orange;
    return Colors.red;
  }

  // ✅ PURE function (safe + predictable)
  List<Map<String, dynamic>> get _filteredItems {
    final query = searchController.text.toLowerCase();

    if (query.isEmpty) return feedInventory;

    return feedInventory.where((item) {
      final feedName = item['feedName'].toString().toLowerCase();
      final batch = item['batch'].toString().toLowerCase();

      return feedName.contains(query) || batch.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredItems;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= HEADER =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Inventory',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const FaIcon(FontAwesomeIcons.plus),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // ================= SEARCH =================
              FormInputTextField(
                label: 'Search stocks',
                placeholder: 'Find stocks by name',
                controller: searchController,
                icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
              ),

              const SizedBox(height: 16),

              // ================= LIST =================
              Expanded(
                child: items.isEmpty
                    ? const Center(child: Text("No inventory items found"))
                    : ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final percent = item['stockPercentage'];

                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: Colors.black.withValues(alpha: 0.05),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ================= TOP =================
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item['feedName'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _stockColor(
                                          percent,
                                        ).withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        "$percent%",
                                        style: TextStyle(
                                          color: _stockColor(percent),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                // ================= DETAILS =================
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _info("Batch", item['batch']),
                                    _info(
                                      "Remaining",
                                      "${item['remainingKg']}kg",
                                    ),
                                    _info(
                                      "Usage/day",
                                      "${item['usagePerDay']}kg",
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 14),

                                // ================= ACTIONS =================
                                Row(
                                  children: [
                                    Expanded(
                                      child: SecondaryButton(
                                        label: 'Details',
                                        icon: const FaIcon(
                                          FontAwesomeIcons.eye,
                                        ),
                                        handlePress: () {},
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: PrimaryButton(
                                        label: 'Restock',
                                        icon: const FaIcon(
                                          FontAwesomeIcons.plus,
                                        ),
                                        handlePress: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
