import 'package:flock_pilot/core/utils/datetime.dart';
import 'package:flock_pilot/features/home/presentation/widgets/carousel.dart';
import 'package:flock_pilot/features/home/presentation/widgets/greeting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));

    // TODO: reload your data here
    // e.g. call API, update state, fetch new list
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
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Greeting(greetingText: getGreeting(context)),
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
                  height: 200,
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
                        Carousel(),
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
