import 'package:carousel_slider/carousel_slider.dart';
import 'package:flock_pilot/core/utils/datetime.dart';
import 'package:flock_pilot/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));

    // TODO: reload your data here
    // e.g. call API, update state, fetch new list
  }

  Widget _stat(String icon, String value) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case "healthy":
        return Colors.green;
      case "active":
        return Colors.blue;
      case "monitoring":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: RefreshIndicator(
            color: Colors.green,
            backgroundColor: Colors.white,
            strokeWidth: 3,
            onRefresh: _refreshData,
            child: ListView(
              children: [
                // HEADER
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getGreeting(),
                          Text(
                            'Michael Darko',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.bell),
                    ),
                    const CircleAvatar(child: Text('MD')),
                  ],
                ),

                const SizedBox(height: 40),

                // CAROUSEL SECTION
                SizedBox(
                  height: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Background image
                        Image.asset(
                          'assets/images/carousel.png',
                          fit: BoxFit.cover,
                        ),

                        // Gradient overlay
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.2),
                                Colors.black.withValues(alpha: 0.6),
                              ],
                            ),
                          ),
                        ),

                        // Carousel
                        CarouselSlider(
                          items: batchData.map((batch) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 10,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Batch name
                                      Text(
                                        batch["batchName"],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),

                                      const Spacer(),

                                      // Status pill
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _statusColor(
                                            batch["status"],
                                          ).withValues(alpha: 0.2),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: _statusColor(
                                              batch["status"],
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          batch["status"],
                                          style: TextStyle(
                                            color: _statusColor(
                                              batch["status"],
                                            ),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // Stats row
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _stat("🐔", "${batch["birds"]}"),
                                          _stat("📅", "${batch["ageWeeks"]}w"),
                                          _stat(
                                            "🌾",
                                            "${batch["feedPerDay"]}kg",
                                          ),
                                          if (batch["eggsPerDay"] > 0)
                                            _stat(
                                              "🥚",
                                              "${batch["eggsPerDay"]}",
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),

                          options: CarouselOptions(
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            enlargeCenterPage: true,
                            viewportFraction: 0.85,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
