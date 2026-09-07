import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/buttons.dart';
import 'package:coach_space/features/auth/data/models/register_request.dart';
import 'package:coach_space/features/auth/data/models/user_role.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_state.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_custom_text_field.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_terms_rich_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController =
  TextEditingController();

  final TextEditingController _emailController =
  TextEditingController();

  final TextEditingController _passwordController =
  TextEditingController();

  UserRole _selectedRole = UserRole.student;

  bool _agreedToTerms = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // =====================================================
  // SIGN UP
  // =====================================================

  void _handleSignup() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.l10n.signupValidationError,
            style: GoogleFonts.inter(
              fontSize: 12,
            ),
          ),
        ),
      );
      return;
    }

    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.l10n.signupTermsError,
            style: GoogleFonts.inter(
              fontSize: 12,
            ),
          ),
        ),
      );
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

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthRegisterSuccess(:final response):
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.emailVerification,
                  (route) => false,
              arguments: response.email.isEmpty
                  ? _emailController.text.trim()
                  : response.email,
            );

          case AuthRegisterFailure(:final message):
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
              12,
              20,
              28,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // =================================================
                // BACK BUTTON
                // =================================================

                IconButton(
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

                const SizedBox(height: 10),

                // =================================================
                // LOGO
                // =================================================

                Center(
                  child: Container(
                    width: 105,
                    height: 105,
                    padding: const EdgeInsets.all(20),
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
                            alpha: 0.03,
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

                const SizedBox(height: 18),

                // =================================================
                // TITLE
                // =================================================

                Center(
                  child: Text(
                    'Join the Future of Learning',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF073F38),
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                    ),
                  ),
                ),

                const SizedBox(height: 7),

                // =================================================
                // SUBTITLE
                // =================================================

                Center(
                  child: Text(
                    'Start your learning journey with Coach Space',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF8A9995),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // =================================================
                // ROLE SELECTOR
                // =================================================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F5F3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFE2EBE8),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildRoleOption(
                          title: 'Student',
                          icon: Icons.menu_book_outlined,
                          role: UserRole.student,
                        ),
                      ),

                      const SizedBox(width: 4),

                      Expanded(
                        child: _buildRoleOption(
                          title: 'Instructor',
                          icon: Icons.business_center_outlined,
                          role: UserRole.instructor,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // =================================================
                // FULL NAME
                // =================================================

                Text(
                  'Full Name',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF31554E),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                SignupCustomTextField(
                  controller: _nameController,
                  hintText: 'Jane Doe',
                  prefixIcon: Icons.person_outline_rounded,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 16),

                // =================================================
                // EMAIL
                // =================================================

                Text(
                  'Email Address',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF31554E),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                SignupCustomTextField(
                  controller: _emailController,
                  hintText: 'jane@example.com',
                  prefixIcon: Icons.mail_outline_rounded,
                  keyboardType:
                  TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 16),

                // =================================================
                // PASSWORD
                // =================================================

                Text(
                  'Password',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF31554E),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                SignupCustomTextField(
                  controller: _passwordController,
                  hintText: '••••••••',
                  prefixIcon:
                  Icons.lock_outline_rounded,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword =
                        !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xFFB4C0BC),
                      size: 18,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // =================================================
                // TERMS
                // =================================================

                SignupTermsRichText(
                  agreed: _agreedToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreedToTerms = value;
                    });
                  },
                ),

                const SizedBox(height: 22),

                // =================================================
                // CREATE ACCOUNT
                // =================================================

                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (previous, current) =>
                  previous is AuthRegisterLoading ||
                      current is AuthRegisterLoading,

                  builder: (context, state) {
                    final isLoading =
                    state is AuthRegisterLoading;

                    return MyButton(
                      text: isLoading
                          ? context
                          .l10n
                          .signupCreatingAccount
                          : 'Create Account',

                      onPressed:
                      isLoading ? () {} : _handleSignup,

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

                const SizedBox(height: 30),

                // =================================================
                // ALREADY HAVE ACCOUNT
                // =================================================

                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.login,
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                            'Already have an account? ',
                            style: GoogleFonts.inter(
                              color:
                              const Color(0xFF8A9995),
                              fontSize: 10,
                            ),
                          ),
                          TextSpan(
                            text: 'Log in',
                            style: GoogleFonts.inter(
                              color: AppColors.primary,
                              fontSize: 10,
                              fontWeight:
                              FontWeight.w700,
                            ),
                          ),
                        ],
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

  // =====================================================
  // ROLE OPTION
  // =====================================================

  Widget _buildRoleOption({
    required String title,
    required IconData icon,
    required UserRole role,
  }) {
    final isSelected = _selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = role;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),

        height: 58,

        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFD7EAE4)
              : Colors.transparent,

          borderRadius: BorderRadius.circular(16),

          border: Border.all(
            color: isSelected
                ? const Color(0xFFC5DED6)
                : Colors.transparent,
          ),

          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.035,
              ),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ]
              : null,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? const Color(0xFF075E4D)
                  : const Color(0xFF7B8985),
            ),

            const SizedBox(width: 8),

            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: isSelected
                    ? FontWeight.w700
                    : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF075E4D)
                    : const Color(0xFF697773),
              ),
            ),
          ],
        ),
      ),
    );
  }
}