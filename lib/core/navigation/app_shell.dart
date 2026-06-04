import 'package:flock_pilot/core/router/route_names.dart';
import 'package:flock_pilot/provider/farm_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class AppShell extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({required this.navigationShell, super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  bool _isFabExtended = true;

  void _onTap(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  bool _onScroll(ScrollNotification notification) {
    if (notification is UserScrollNotification) {
      if (notification.direction == ScrollDirection.reverse) {
        if (_isFabExtended) {
          setState(() => _isFabExtended = false);
        }
      }

      if (notification.direction == ScrollDirection.forward) {
        if (!_isFabExtended) {
          setState(() => _isFabExtended = true);
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final farm = ref.watch(farmProvider).farm;

    return Scaffold(
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),

        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },

        child: _isFabExtended
            ? FloatingActionButton.extended(
                key: const ValueKey('extended_fab'),

                onPressed: () => context.push(
                  RouteNames.aiAssistant.replaceFirst(
                    ':farmId',
                    farm?.id ?? '',
                  ),
                ),

                backgroundColor: Theme.of(context).colorScheme.primary,

                elevation: 4,

                icon: Image.asset(
                  'assets/images/flock_ai.png',
                  width: 24,
                  height: 24,
                ),

                label: const Text('Ask CoopMind AI'),
              )
            : FloatingActionButton(
                key: const ValueKey('normal_fab'),

                onPressed: () => context.push(
                  RouteNames.aiAssistant.replaceFirst(
                    ':farmId',
                    farm?.id ?? '',
                  ),
                ),

                backgroundColor: Theme.of(context).colorScheme.primary,

                elevation: 4,

                child: Image.asset(
                  'assets/images/flock_ai.png',
                  width: 50,
                  height: 50,
                ),
              ),
      ),

      body: NotificationListener<ScrollNotification>(
        onNotification: _onScroll,

        child: RefreshIndicator(
          color: Colors.green,
          backgroundColor: Colors.white,
          strokeWidth: 3,
          onRefresh: _refreshData,

          child: widget.navigationShell,
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,

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
            icon: FaIcon(FontAwesomeIcons.boxesStacked),
            label: 'Inventory',
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
