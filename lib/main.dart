import 'package:flutter/material.dart';

import 'core/di/injection_container.dart';
import 'core/routing/app_router.dart';
import 'core/routing/app_routes.dart';
import 'core/theming/app_theme.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const CoachSpaceApp());
}

class CoachSpaceApp extends StatelessWidget {
  const CoachSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coach Space',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter().generateRoute,
      initialRoute: AppRoutes.login,
      locale: const Locale('ar'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
