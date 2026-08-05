import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/buttons.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_bottom_waves_painter.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_custom_text_field.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_name_text_field.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_terms_rich_text.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                  horizontal: 30,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Logo_img.png',
                            width: 150,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Join the Future \n of Learning',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textBody,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SignupNameTextField(name: 'FULL NAME'),
                    const SizedBox(height: 10),
                    const SignupCustomTextField(
                      hintText: 'Jane Doe',
                      borderColor: AppColors.borderColor,
                    ),
                    const SizedBox(height: 20),
                    const SignupNameTextField(name: 'EMAIL ADDRESS'),
                    const SizedBox(height: 10),
                    const SignupCustomTextField(
                      hintText: 'jane@example.com',
                      borderColor: AppColors.borderColor,
                    ),
                    const SizedBox(height: 20),
                    const SignupNameTextField(name: 'PASSWORD'),
                    const SizedBox(height: 10),
                    const SignupCustomTextField(
                      hintText: '•••••••••',
                      borderColor: AppColors.borderColor,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox.adaptive(
                          value: false,
                          onChanged: (_) {},
                        ),
                        const Expanded(
                          child: Text(
                            'I AGREE TO THE TERMS OF SERVICE AND PRIVACY POLICY',
                            style: TextStyle(
                              color: AppColors.textLight,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    MyButton(
                      text: 'Create Account',
                      onPressed: () {},
                      color: AppColors.primary,
                      textColor: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      borderRadius: 12,
                      width: double.infinity,
                      height: 60,
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: SignupTermsRichText(
                        firstText: 'Already have an account? ',
                        secondText: 'Log In',
                        firstColor: AppColors.textLight,
                        secondColor: AppColors.primary,
                        fontSize: 16,
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
