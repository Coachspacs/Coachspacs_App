import 'package:flutter/material.dart';

import 'core/theming/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CoachSpacsApp());
}

class CoachSpacsApp extends StatelessWidget {
  const CoachSpacsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coach Spacs',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
