import 'package:flock_pilot/core/constants/app_constants.dart';
import 'package:flock_pilot/provider/farm_provider.dart';
import 'package:flock_pilot/provider/user_provider.dart';
import 'package:flock_pilot/shared/widgets/action_card.dart';
import 'package:flock_pilot/shared/enums/cards.dart';
import 'package:flock_pilot/shared/utils/datetime.dart';
import 'package:flock_pilot/features/home/presentation/widgets/carousel.dart';
import 'package:flock_pilot/features/home/presentation/widgets/greeting.dart';
import 'package:flock_pilot/shared/widgets/notification_alert_card.dart';
import 'package:flock_pilot/features/home/presentation/widgets/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final farmState = ref.watch(farmProvider);

    if (farmState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (farmState.error != null) {
      return Scaffold(body: Center(child: Text(farmState.error!)));
    }

    final farm = farmState.farm;

    if (farm == null) {
      return const Scaffold(body: Center(child: Text('No farm found')));
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Greeting(greetingText: getGreeting(context)),
                      Text(
                        user?.name ?? '',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.bell),
                ),
                CircleAvatar(
                  foregroundColor: Colors.white,
                  child: Text(
                    '${user?.name.split(' ').first[0]} ${user?.name.split(' ').last[0]}',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

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
                    Carousel(batchData: farm.flocks),
                  ],
                ),
              ),
            ),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              primary: false,
              padding: const EdgeInsets.symmetric(vertical: 20),

              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,

              children: statsData
                  .map(
                    (stat) => StatCard(
                      icon: FaIcon(stat['icon']),
                      cardName: (stat['cardName']),
                      statFigure: stat['statFigure'],
                      rateChange: stat['rateChange'],
                      cardColor: stat['cardColor'],
                    ),
                  )
                  .toList(),
            ),

            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: Row(
                spacing: 7,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: actionCards
                    .map(
                      (action) => Expanded(
                        child: ActionCard(
                          onTap: () => context.push(action['route']),
                          color: action['cardColor'],
                          icon: FaIcon(
                            action['icon'],
                            color: Colors.white,
                            size: 24,
                          ),
                          label: action['actionLabel'],
                          textPosition: CardTextPosition.bottom,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            Text(
              'Alerts & Notifications',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: notificationsData.take(3).map((notification) {
                  return NotificationAlertCard(
                    title: notification["title"],
                    message: notification["message"],
                    time: notification["time"],
                    type: notification["type"],
                    icon: notification["icon"],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
