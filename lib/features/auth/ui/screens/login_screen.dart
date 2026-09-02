import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/buttons.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _rememberMe = false;
  bool _obscurePassword = true;

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
        SnackBar(
          content: Text(
            context.l10n.loginValidationError,
            style: GoogleFonts.inter(),
          ),
        ),
      );
      return;
    }

    context.read<AuthCubit>().login(
      email: email,
      password: password,
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.inter(
        fontSize: 14,
        color: AppColors.textLight,
      ),

      prefixIcon: Icon(
        icon,
        color: AppColors.textLight,
        size: 20,
      ),

      suffixIcon: suffixIcon,

      filled: true,
      fillColor: AppColors.white,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.borderColor,
          width: 1,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.borderColor,
          width: 1,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.4,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: GoogleFonts.inter(),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bgDefault,

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              16,
              30,
              16,
              20,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                // --------------------------------------------------
                // LOGO
                // --------------------------------------------------

                Center(
                  child: Image.asset(
                    'assets/images/Logo_img.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 18),

                // --------------------------------------------------
                // WELCOME TITLE
                // --------------------------------------------------

                Text(
                  context.l10n.loginWelcome,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 8),

                // --------------------------------------------------
                // SUBTITLE
                // --------------------------------------------------

                Text(
                  'Empower your career with top-tier coaching',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textLight,
                  ),
                ),

                // --------------------------------------------------
                // SPACE BEFORE FORM
                // --------------------------------------------------

                const SizedBox(height: 58),

                // --------------------------------------------------
                // EMAIL LABEL
                // --------------------------------------------------

                Text(
                  context.l10n.loginEmailLabel,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 8),

                // --------------------------------------------------
                // EMAIL FIELD
                // --------------------------------------------------

                SizedBox(
                  height: 58,
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,

                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),

                    decoration: _inputDecoration(
                      hintText: 'jane@example.com',
                      icon: Icons.email_outlined,
                    ),
                  ),
                ),

                const SizedBox(height: 26),

                // --------------------------------------------------
                // PASSWORD LABEL
                // --------------------------------------------------

                Text(
                  context.l10n.loginPasswordLabel,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 8),

                // --------------------------------------------------
                // PASSWORD FIELD
                // --------------------------------------------------

                SizedBox(
                  height: 58,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,

                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),

                    decoration: _inputDecoration(
                      hintText: '••••••••',
                      icon: Icons.lock_outline,

                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },

                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.textLight,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // --------------------------------------------------
                // REMEMBER ME + FORGOT PASSWORD
                // --------------------------------------------------

                Row(
                  children: [

                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _rememberMe,

                        activeColor: AppColors.primary,

                        side: const BorderSide(
                          color: AppColors.borderColor,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),

                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                      ),
                    ),

                    const SizedBox(width: 6),

                    Text(
                      'Remember me',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppColors.textLight,
                      ),
                    ),

                    const Spacer(),

                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.forgotPassword,
                        );
                      },

                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                      ),

                      child: Text(
                        context.l10n.loginForgotPassword,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // --------------------------------------------------
                // SIGN IN BUTTON
                // --------------------------------------------------

                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (previous, current) =>
                  previous is AuthLoginLoading ||
                      current is AuthLoginLoading,

                  builder: (context, state) {
                    final isLoading =
                    state is AuthLoginLoading;

                    return MyButton(
                      text: isLoading
                          ? context.l10n.loginButtonLoading
                          : context.l10n.loginButton,

                      onPressed:
                      isLoading ? () {} : _handleLogin,

                      color: AppColors.primary,
                      textColor: AppColors.white,

                      fontSize: 15,
                      fontWeight: FontWeight.w700,

                      borderRadius: 10,

                      width: double.infinity,
                      height: 54,

                      padding: EdgeInsets.zero,
                    );
                  },
                ),


                const SizedBox(height: 20),



                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Icon(
                      Icons.verified_user_outlined,
                      size: 14,
                      color: AppColors.textLight,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      '100% encrypted and secure connection',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),


                const SizedBox(height: 42),



                Row(
                  children: [

                    const Expanded(
                      child: Divider(
                        color: AppColors.borderColor,
                        thickness: 0.8,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),

                      child: Text(
                        'OR',
                        style: GoogleFonts.inter(
                          color: AppColors.textLight,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const Expanded(
                      child: Divider(
                        color: AppColors.borderColor,
                        thickness: 0.8,
                      ),
                    ),
                  ],
                ),


                const SizedBox(height: 28),



                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.signup,
                      );
                    },

                    child: RichText(
                      text: TextSpan(
                        children: [

                          TextSpan(
                            text:
                            "Don't have an account? ",

                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: AppColors.textLight,
                            ),
                          ),

                          TextSpan(
                            text: 'Create account',

                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}