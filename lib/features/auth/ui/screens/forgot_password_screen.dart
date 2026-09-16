import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/buttons.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController =
  TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // =====================================================
  // SEND RESET LINK
  // =====================================================

  void _sendResetLink() {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.l10n.forgotPasswordEmailEmpty,
            style: GoogleFonts.inter(
              fontSize: 12,
            ),
          ),
        ),
      );

      return;
    }

    context.read<AuthCubit>().forgotPassword(email);
  }

  // =====================================================
  // EMAIL FIELD
  // =====================================================

  InputDecoration _emailDecoration() {
    return InputDecoration(
      hintText: 'Enter your email',

      hintStyle: GoogleFonts.inter(
        color: const Color(0xFFB4C0BC),
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),

      prefixIcon: const Icon(
        Icons.mail_outline_rounded,
        color: Color(0xFFB4C0BC),
        size: 19,
      ),

      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
        borderSide: const BorderSide(
          color: Color(0xFFD9E6E1),
          width: 1,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
        borderSide: const BorderSide(
          color: Color(0xFFD9E6E1),
          width: 1,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.2,
        ),
      ),
    );
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state) {
        // =================================================
        // SUCCESS
        // =================================================

          case AuthPasswordSuccess():
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  context.l10n.forgotPasswordSuccess,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                  ),
                ),
              ),
            );

            // UI FLOW FOR NOW
            // Backend reset functionality will be
            // connected later.

            Navigator.pushReplacementNamed(
              context,
              AppRoutes.resetPassword,
            );

        // =================================================
        // FAILURE
        // =================================================

          case AuthPasswordFailure(:final message):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  message,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                  ),
                ),
              ),
            );

          default:
            break;
        }
      },

      child: Scaffold(
        backgroundColor: const Color(0xFFF7FAF9),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              20,
              10,
              20,
              28,
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.stretch,

              children: [

                // =================================================
                // BACK BUTTON
                // =================================================

                Align(
                  alignment: Alignment.centerLeft,

                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    padding: EdgeInsets.zero,

                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),

                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Color(0xFF073F38),
                      size: 21,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // =================================================
                // LOGO
                // =================================================

                Center(
                  child: Container(
                    width: 125,
                    height: 125,
                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,

                      border: Border.all(
                        color: const Color(0xFFDCEAE5),
                        width: 1,
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: 0.035,
                          ),
                          blurRadius: 18,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),

                    child: Image.asset(
                      'assets/images/Logo_img.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // =================================================
                // TITLE
                // =================================================

                Text(
                  context.l10n.forgotPasswordTitle,
                  textAlign: TextAlign.center,

                  style: GoogleFonts.inter(
                    color: const Color(0xFF073F38),
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.4,
                  ),
                ),

                const SizedBox(height: 9),

                // =================================================
                // DESCRIPTION
                // =================================================

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),

                  child: Text(
                    context.l10n.forgotPasswordSubtitle,
                    textAlign: TextAlign.center,

                    style: GoogleFonts.inter(
                      color: const Color(0xFF8A9995),
                      fontSize: 11,
                      height: 1.65,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                const SizedBox(height: 34),

                // =================================================
                // EMAIL LABEL
                // =================================================

                Padding(
                  padding: const EdgeInsets.only(
                    left: 4,
                  ),

                  child: Text(
                    context.l10n.forgotPasswordEmailLabel,

                    style: GoogleFonts.inter(
                      color: const Color(0xFF31554E),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 7),

                // =================================================
                // EMAIL FIELD
                // =================================================

                SizedBox(
                  height: 52,

                  child: TextField(
                    controller: _emailController,

                    keyboardType:
                    TextInputType.emailAddress,

                    textInputAction:
                    TextInputAction.done,

                    style: GoogleFonts.inter(
                      color: const Color(0xFF073F38),
                      fontSize: 12,
                    ),

                    decoration: _emailDecoration(),
                  ),
                ),

                const SizedBox(height: 22),

                // =================================================
                // SEND RESET LINK
                // =================================================

                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (previous, current) =>
                  previous is AuthPasswordLoading ||
                      current is AuthPasswordLoading,

                  builder: (context, state) {
                    final isLoading =
                    state is AuthPasswordLoading;

                    return MyButton(
                      text: isLoading
                          ? context.l10n.forgotPasswordSending
                          : context.l10n.forgotPasswordButton,

                      onPressed: isLoading
                          ? () {}
                          : _sendResetLink,

                      color: AppColors.primary,
                      textColor: AppColors.white,

                      fontSize: 13,
                      fontWeight: FontWeight.w700,

                      borderRadius: 26,

                      width: double.infinity,
                      height: 50,

                      padding: EdgeInsets.zero,
                    );
                  },
                ),

                const SizedBox(height: 25),

                // =================================================
                // BACK TO LOGIN
                // =================================================

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      minimumSize: Size.zero,

                      tapTargetSize:
                      MaterialTapTargetSize.shrinkWrap,
                    ),

                    child: Text(
                      context.l10n.forgotPasswordBackToLogin,

                      style: GoogleFonts.inter(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}