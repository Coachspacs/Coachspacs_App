import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/buttons.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.forgotPasswordEmailEmpty)),
      );
      return;
    }
    context.read<AuthCubit>().forgotPassword(email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthPasswordSuccess():
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.l10n.forgotPasswordSuccess)),
            );
            Navigator.pop(context);
          case AuthPasswordFailure(:final message):
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 48),
                    const Text(
                      'Coach Space',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      color: AppColors.textLight,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 430),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.bgDefault,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.border),
                            ),
                            child: const Icon(
                              Icons.lock_reset,
                              color: AppColors.primary,
                              size: 40,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            context.l10n.forgotPasswordTitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.textBody,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            context.l10n.forgotPasswordSubtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.textLight,
                              fontSize: 16,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(
                              context.l10n.forgotPasswordEmailLabel,
                              style: const TextStyle(
                                color: AppColors.textBody,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textDirection: TextDirection.ltr,
                            decoration: InputDecoration(
                              hintText: 'name@example.com',
                              prefixIcon: const Icon(Icons.mail_outline),
                              filled: true,
                              fillColor: AppColors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.borderColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.borderColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          BlocBuilder<AuthCubit, AuthState>(
                            buildWhen: (previous, current) =>
                                previous is AuthPasswordLoading ||
                                current is AuthPasswordLoading,
                            builder: (context, state) {
                              final isLoading = state is AuthPasswordLoading;
                              return MyButton(
                                text: isLoading
                                    ? context.l10n.forgotPasswordSending
                                    : context.l10n.forgotPasswordButton,
                                onPressed: isLoading ? () {} : _sendResetLink,
                                color: AppColors.primary,
                                textColor: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                borderRadius: 12,
                                width: double.infinity,
                                height: 54,
                                padding: EdgeInsets.zero,
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              context.l10n.forgotPasswordBackToLogin,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
