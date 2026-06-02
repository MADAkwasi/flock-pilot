import 'package:flock_pilot/core/router/route_names.dart';
import 'package:flock_pilot/features/batches/presentation/widgets/batch_card.dart';
import 'package:flock_pilot/features/batches/presentation/widgets/heading_card.dart';
import 'package:flock_pilot/provider/farm_provider.dart';
import 'package:flock_pilot/shared/models/flock_model.dart';
import 'package:flock_pilot/shared/widgets/fallback.dart';
import 'package:flock_pilot/shared/widgets/form_input_text_field.dart';
import 'package:flock_pilot/shared/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class BatchesScreen extends ConsumerStatefulWidget {
  const BatchesScreen({super.key});

  @override
  ConsumerState<BatchesScreen> createState() => _BatchesScreenState();
}

class _BatchesScreenState extends ConsumerState<BatchesScreen> {
  final filters = const ['All', 'Layers', 'Broilers'];

  String selectedFilter = 'All';

  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<FlockModel> _applyFilters(List<FlockModel> flocks) {
    final search = searchController.text.toLowerCase();

    return flocks.where((batch) {
      final matchesType = selectedFilter == 'All'
          ? true
          : batch.flockType.toLowerCase() ==
                selectedFilter.toLowerCase().replaceAll('s', '');

      final matchesSearch = batch.name.toLowerCase().contains(search);

      return matchesType && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final farmState = ref.watch(farmProvider);

    if (farmState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (farmState.error != null) {
      return Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmptyStateCard(
                    icon: FontAwesomeIcons.triangleExclamation,
                    title: "Something went wrong",
                    message: farmState.error!,
                    actionLabel: "Retry",
                    onAction: () => ref.invalidate(farmProvider),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final farm = farmState.farm;
    final flocks = farm?.flocks ?? [];

    if (flocks.isEmpty) {
      return Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmptyStateCard(
                    icon: FontAwesomeIcons.tractor,
                    title: "No batches yet",
                    message:
                        "Start by creating your first flock to begin tracking production and performance.",
                    actionLabel: "Add Batch",
                    onAction: () {
                      // context.push(RouteNames.createBatch);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final filtered = _applyFilters(flocks);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Batch Management',
              style: Theme.of(context).textTheme.headlineLarge,
            ),

            const SizedBox(height: 15),

            HeadingCard(batches: flocks),

            const SizedBox(height: 15),

            FormInputTextField(
              label: 'Search Batches',
              placeholder: 'Find batches by name',
              controller: searchController,
              icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
            ),

            const SizedBox(height: 10),

            Row(
              children: filters.map((filter) {
                final isSelected = selectedFilter == filter;

                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextButton(
                    onPressed: () => setState(() {
                      selectedFilter = filter;
                    }),
                    style: isSelected
                        ? TextButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            foregroundColor: Colors.white,
                          )
                        : TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                    child: Text(filter),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 15),

            if (filtered.isEmpty)
              const EmptyStateCard(
                icon: FontAwesomeIcons.magnifyingGlass,
                title: "No matches found",
                message: "Try adjusting your search or filter.",
              )
            else
              ...filtered.map(
                (batch) => BatchCard(
                  batch: batch,
                  onTap: () {
                    context.push(
                      RouteNames.batchDetails.replaceFirst(
                        ':batchId',
                        batch.id,
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 20),

            SecondaryButton(
              label: 'Add New Batch',
              handlePress: () {},
              icon: const FaIcon(FontAwesomeIcons.plus),
            ),
          ],
        ),
      ),
    );
  }
}
