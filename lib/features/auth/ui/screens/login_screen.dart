import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_state.dart';

import '../../../../core/theming/app_colors.dart';

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

  // Coach Space brand colors
  static const Color _primary = Color(0xFF0B6B5A);
  static const Color _darkText = Color(0xFF173D37);
  static const Color _secondaryText = Color(0xFF70827E);
  static const Color _border = Color(0xFFD7E2DF);
  static const Color _background = Color(0xFFF7FAF9);

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
        const SnackBar(
          content: Text('Please enter your email and password.'),
        ),
      );
      return;
    }

    context.read<AuthCubit>().login(
      email: email,
      password: password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: _background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              22,
              30,
              22,
              24,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 430,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ─────────────────────────────
                    // Logo
                    // ─────────────────────────────
                    Center(
                      child: Image.asset(
                        'assets/images/Logo_img.png',
                        width: 72,
                        height: 72,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ─────────────────────────────
                    // Welcome title
                    // ─────────────────────────────
                    const Center(
                      child: Text(
                        'Welcome back to CoachSpace',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: _darkText,
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Center(
                      child: Text(
                        'Empower your career with top-tier coaching',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: _secondaryText,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // ─────────────────────────────
                    // Email
                    // ─────────────────────────────
                    const _FieldLabel(
                      text: 'Email address',
                    ),

                    const SizedBox(height: 7),

                    _AuthTextField(
                      controller: _emailController,
                      hintText: 'jane@example.com',
                      prefixIcon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 17),

                    // ─────────────────────────────
                    // Password
                    // ─────────────────────────────
                    const _FieldLabel(
                      text: 'Password',
                    ),

                    const SizedBox(height: 7),

                    _AuthTextField(
                      controller: _passwordController,
                      hintText: '••••••••',
                      prefixIcon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 17,
                          color: _secondaryText,
                        ),
                      ),
                    ),

                    const SizedBox(height: 9),

                    // ─────────────────────────────
                    // Remember + Forgot password
                    // ─────────────────────────────
                    Row(
                      children: [
                        SizedBox(
                          width: 22,
                          height: 22,
                          child: Checkbox(
                            value: _rememberMe,
                            activeColor: _primary,
                            side: const BorderSide(
                              color: Color(0xFFB9C8C4),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Remember me',
                          style: TextStyle(
                            fontSize: 10,
                            color: _secondaryText,
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
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: _primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // ─────────────────────────────
                    // Sign in
                    // ─────────────────────────────
                    BlocBuilder<AuthCubit, AuthState>(
                      buildWhen: (previous, current) =>
                      previous is AuthLoginLoading ||
                          current is AuthLoginLoading,
                      builder: (context, state) {
                        final isLoading =
                        state is AuthLoginLoading;

                        return SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton(
                            onPressed:
                            isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _primary,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor:
                              _primary.withValues(alpha: 0.55),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text(
                                  isLoading
                                      ? 'Signing in...'
                                      : 'Sign in',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                if (!isLoading) ...[
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.arrow_forward,
                                    size: 15,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 14),

                    // ─────────────────────────────
                    // Secure connection
                    // ─────────────────────────────
                    const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified_user_outlined,
                            size: 12,
                            color: Color(0xFF78908A),
                          ),
                          SizedBox(width: 5),
                          Text(
                            '100% encrypted and secure connection',
                            style: TextStyle(
                              fontSize: 8.5,
                              color: _secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ─────────────────────────────
                    // Divider
                    // ─────────────────────────────
                    const Divider(
                      height: 1,
                      color: _border,
                    ),

                    const SizedBox(height: 15),

                    // ─────────────────────────────
                    // Create account
                    // ─────────────────────────────
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 9.5,
                              color: _secondaryText,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.signup,
                              );
                            },
                            child: const Text(
                              'Create account',
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                color: _primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// FIELD LABEL
// ═══════════════════════════════════════════════

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Color(0xFF3C5751),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// TEXT FIELD
// ═══════════════════════════════════════════════

class _AuthTextField extends StatelessWidget {
  const _AuthTextField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 11,
          color: Color(0xFF344640),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 11,
            color: Color(0xFF9AA9A5),
          ),
          prefixIcon: Icon(
            prefixIcon,
            size: 16,
            color: Color(0xFF879A95),
          ),
          suffixIcon: suffixIcon,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 38,
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 38,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(
              color: AppColors.primary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(
              color: AppColors.primary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}