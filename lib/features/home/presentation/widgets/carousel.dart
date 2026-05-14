import 'package:carousel_slider/carousel_slider.dart';
import 'package:flock_pilot/data/dummy_data.dart';
import 'package:flock_pilot/features/home/presentation/widgets/carousel_card.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: batchData.map((batch) {
        return CarouselCard(batch: batch);
      }).toList(),

      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        enlargeCenterPage: true,
        viewportFraction: 0.85,
      ),
    );
  }
}
