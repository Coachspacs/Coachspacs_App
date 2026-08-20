import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/buttons.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_state.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_bottom_waves_painter.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_custom_text_field.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_name_text_field.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_terms_rich_text.dart';

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
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.loginValidationError)),
      );
      return;
    }

    context.read<AuthCubit>().login(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
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
                      Text(
                        context.l10n.loginWelcome,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 35),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: SignupNameTextField(
                          name: context.l10n.loginEmailLabel,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SignupCustomTextField(
                        hintText: 'jane@example.com',
                        borderColor: AppColors.borderColor,
                        controller: _emailController,
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: SignupNameTextField(
                          name: context.l10n.loginPasswordLabel,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SignupCustomTextField(
                        hintText: '••••••••',
                        borderColor: AppColors.borderColor,
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 30),
                      BlocBuilder<AuthCubit, AuthState>(
                        buildWhen: (previous, current) =>
                            previous is AuthLoginLoading ||
                            current is AuthLoginLoading,
                        builder: (context, state) {
                          final isLoading = state is AuthLoginLoading;
                          return MyButton(
                            text: isLoading
                                ? context.l10n.loginButtonLoading
                                : context.l10n.loginButton,
                            onPressed: isLoading ? () {} : _handleLogin,
                            color: AppColors.primary,
                            textColor: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            borderRadius: 12,
                            width: double.infinity,
                            height: 55,
                            padding: EdgeInsets.zero,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.forgotPassword,
                          );
                        },
                        child: Text(
                          context.l10n.loginForgotPassword,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: SignupTermsRichText(
                          firstText: context.l10n.loginNoAccount,
                          secondText: context.l10n.loginRegister,
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
      ),
    );
  }
}
