import 'package:flock_pilot/core/constants/app_constants.dart';
import 'package:flock_pilot/features/settings/presentation/widgets/settings_tile.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Settings', style: Theme.of(context).textTheme.headlineLarge),

            const SizedBox(height: 15),
            // ================= PROFILE SECTION =================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(radius: 28, child: Text('MD')),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Michael Darko',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('Farm Manager', style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================= SETTINGS LIST =================
            ...settingsOptions.map(
              (option) => SettingsTile(
                icon: option['icon'],
                title: option['title'],
                subtitle: option['subtitle'],
                onTap: () {},
              ),
            ),

            const SizedBox(height: 30),

            // ================= LOGOUT =================
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
