import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({required this.navigationShell, super.key});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,

      initialLocation: index == navigationShell.currentIndex,
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));

    // TODO: reload your data here
    // e.g. call API, update state, fetch new list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},

        child: Image.asset('assets/images/flock_ai.png'),
      ),
      body: RefreshIndicator(
        color: Colors.green,
        backgroundColor: Colors.white,
        strokeWidth: 3,
        onRefresh: _refreshData,
        child: navigationShell,
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,

        onDestinationSelected: _onTap,

        destinations: const [
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.houseChimney),
            label: 'Home',
          ),

          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.egg),
            label: 'Batches',
          ),

          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.buildingWheat),
            label: 'Feed',
          ),

          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.gear),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
