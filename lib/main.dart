// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/app_router.dart';
import 'services/isar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isarService = IsarService();
  await isarService.initializeIsar();

  runApp(ProviderScope(overrides: [
    isarServiceProvider.overrideWithValue(isarService),
  ], child: MyApp()));
}

final isarServiceProvider = Provider<IsarService>((ref) {
  throw UnimplementedError();
});

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = AppRouter().router;

    return MaterialApp.router(
      title: 'EventFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(73, 81, 86, 100),
        ),
        useMaterial3: true,
      ),
      routerDelegate: appRouter.routerDelegate,
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
    );
  }
}
