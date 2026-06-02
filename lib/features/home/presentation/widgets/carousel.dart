import 'package:carousel_slider/carousel_slider.dart';
import 'package:flock_pilot/features/home/presentation/widgets/carousel_card.dart';
import 'package:flock_pilot/shared/models/flock_model.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  const Carousel({required this.batchData, super.key});

  final List<FlockModel> batchData;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: batchData.isEmpty
          ? [
              Center(
                child: Text(
                  "No batches available",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(color: Colors.white),
                ),
              ),
            ]
          : batchData.map((batch) {
              return CarouselCard(batch: batch);
            }).toList(),

      options: CarouselOptions(
        autoPlay: batchData.isNotEmpty,
        autoPlayInterval: const Duration(seconds: 5),
        enlargeCenterPage: true,
        viewportFraction: 0.85,
      ),
    );
  }
}
