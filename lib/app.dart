import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_team/core/router/app_router.dart';
import 'package:gym_team/core/theme/app_theme.dart';
import 'package:gym_team/core/theme/theme_color_notifier.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final colorName =
        ref.watch(themeColorNotifierProvider).valueOrNull ?? 'purple';
    return MaterialApp.router(
      title: 'Gym Team',
      theme: AppTheme.darkWithSeed(AppTheme.seedForName(colorName)),
      routerConfig: router,
    );
  }
}
