import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/buttons.dart';
import 'package:coach_space/features/auth/data/models/register_request.dart';
import 'package:coach_space/features/auth/data/models/user_role.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_state.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_bottom_waves_painter.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_custom_text_field.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_name_text_field.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_terms_rich_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  UserRole _selectedRole = UserRole.student;
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.signupValidationError)),
      );
      return;
    }

    if (!_agreedToTerms) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.signupTermsError)));
      return;
    }

    context.read<AuthCubit>().register(
      RegisterRequest(
        fullName: name,
        email: email,
        password: password,
        role: _selectedRole,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthRegisterSuccess(:final response):
            // New accounts are unverified; the backend emails a verification
            // link. Send the user to the verification screen.
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.emailVerification,
              (route) => false,
              arguments: response.email.isEmpty
                  ? _emailController.text.trim()
                  : response.email,
            );
          case AuthRegisterFailure(:final message):
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          default:
            break;
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
                            Text(
                              context.l10n.signupTitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.textBody,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SignupNameTextField(name: context.l10n.signupNameLabel),
                      const SizedBox(height: 10),
                      SignupCustomTextField(
                        hintText: context.l10n.signupNameHint,
                        borderColor: AppColors.borderColor,
                        controller: _nameController,
                      ),
                      const SizedBox(height: 20),
                      SignupNameTextField(name: context.l10n.signupEmailLabel),
                      const SizedBox(height: 10),
                      SignupCustomTextField(
                        hintText: 'jane@example.com',
                        borderColor: AppColors.borderColor,
                        controller: _emailController,
                      ),
                      const SizedBox(height: 20),
                      SignupNameTextField(
                        name: context.l10n.signupPasswordLabel,
                      ),
                      const SizedBox(height: 10),
                      SignupCustomTextField(
                        hintText: '•••••••••',
                        borderColor: AppColors.borderColor,
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      SignupNameTextField(name: context.l10n.signupRoleLabel),
                      const SizedBox(height: 10),
                      SegmentedButton<UserRole>(
                        segments: [
                          ButtonSegment(
                            value: UserRole.student,
                            label: Text(context.l10n.signupRoleStudent),
                          ),
                          ButtonSegment(
                            value: UserRole.instructor,
                            label: Text(context.l10n.signupRoleInstructor),
                          ),
                        ],
                        selected: {_selectedRole},
                        onSelectionChanged: (selection) {
                          setState(() => _selectedRole = selection.first);
                        },
                        style: ButtonStyle(
                          visualDensity: VisualDensity.comfortable,
                          foregroundColor: WidgetStateProperty.resolveWith(
                            (states) => states.contains(WidgetState.selected)
                                ? AppColors.white
                                : AppColors.textLight,
                          ),
                          backgroundColor: WidgetStateProperty.resolveWith(
                            (states) => states.contains(WidgetState.selected)
                                ? AppColors.primary
                                : AppColors.white,
                          ),
                          side: WidgetStateProperty.all(
                            const BorderSide(color: AppColors.borderColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox.adaptive(
                            value: _agreedToTerms,
                            onChanged: (value) {
                              setState(() => _agreedToTerms = value ?? false);
                            },
                          ),
                          Expanded(
                            child: Text(
                              context.l10n.signupTermsAgree,
                              style: const TextStyle(
                                color: AppColors.textLight,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<AuthCubit, AuthState>(
                        buildWhen: (previous, current) =>
                            previous is AuthRegisterLoading ||
                            current is AuthRegisterLoading,
                        builder: (context, state) {
                          final isLoading = state is AuthRegisterLoading;
                          return MyButton(
                            text: isLoading
                                ? context.l10n.signupCreatingAccount
                                : context.l10n.signupCreateAccount,
                            onPressed: isLoading ? () {} : _handleSignup,
                            color: AppColors.primary,
                            textColor: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            borderRadius: 12,
                            width: double.infinity,
                            height: 60,
                            padding: EdgeInsets.zero,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: SignupTermsRichText(
                          firstText: context.l10n.signupHasAccount,
                          secondText: context.l10n.signupLogin,
                          firstColor: AppColors.textLight,
                          secondColor: AppColors.primary,
                          fontSize: 16,
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.login);
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
