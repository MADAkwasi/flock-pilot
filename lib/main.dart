import 'package:flock_pilot/core/api/api_client.dart';
import 'package:flock_pilot/core/router/app_router.dart';
import 'package:flock_pilot/core/theme/app_theme.dart';
import 'package:flock_pilot/provider/auth_provider.dart';
import 'package:flock_pilot/shared/utils/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

void main() {
  final storage = TokenStorage();
  ApiClient.init(storage);

  runApp(const ProviderScope(child: MainApp()));
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final authNotifier = ref.read(authProvider.notifier);

      await authNotifier.bootstrap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: ref.watch(appRouterProvider),
      ),
    );
  }
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}
