import 'package:flutter/material.dart';

import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/buttons.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_bottom_waves_painter.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_custom_text_field.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_name_text_field.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_terms_rich_text.dart';

/// Demo credentials: email `1` + password `1` navigate to the home screen.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final isDemoCredentials = _emailController.text.trim() == '1' &&
        _passwordController.text == '1';

    if (isDemoCredentials) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Image.asset('assets/images/Logo_img.png', width: 110),
                    const SizedBox(height: 20),
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 35),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: SignupNameTextField(name: 'EMAIL ADDRESS'),
                    ),
                    const SizedBox(height: 8),
                    SignupCustomTextField(
                      hintText: 'jane@example.com',
                      borderColor: AppColors.borderColor,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: SignupNameTextField(name: 'PASSWORD'),
                    ),
                    const SizedBox(height: 8),
                    SignupCustomTextField(
                      hintText: '••••••••',
                      borderColor: AppColors.borderColor,
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    MyButton(
                      text: 'Login →',
                      onPressed: _handleLogin,
                      color: AppColors.primary,
                      textColor: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      borderRadius: 12,
                      width: double.infinity,
                      height: 55,
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SignupTermsRichText(
                        firstText: "Don't have an account? ",
                        secondText: 'Register',
                        firstColor: AppColors.textLight,
                        secondColor: AppColors.primary,
                        fontSize: 16,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.signup);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 146,
              child: CustomPaint(painter: SignupBottomWavesPainter()),
            ),
          ],
        ),
      ),
    );
  }
}
