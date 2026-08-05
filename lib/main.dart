import 'package:coach_space/features/signup/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import 'core/theming/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: Scaffold(body: SignupScreen()),
    );
  }
}
