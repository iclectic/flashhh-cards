import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/dependencies.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class FlashhhApp extends ConsumerWidget {
  const FlashhhApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final themeMode =
        ref.watch(themeModeProvider).asData?.value ?? ThemeMode.system;
    return MaterialApp.router(
      title: 'Flashhh',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: router,
      restorationScopeId: 'flashhh',
      debugShowCheckedModeBanner: false,
    );
  }
}
