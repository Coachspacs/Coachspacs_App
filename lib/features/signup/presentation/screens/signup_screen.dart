import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/buttons.dart';
import 'package:coach_space/features/auth/data/models/register_request.dart';
import 'package:coach_space/features/auth/data/models/user_role.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_state.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_custom_text_field.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_name_text_field.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_role_card.dart';
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

  void _handleSignup() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.l10n.signupValidationError,
            style: GoogleFonts.inter(),
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
            style: GoogleFonts.inter(),
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
                  style: GoogleFonts.inter(),
                ),
              ),
            );

          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bgDefault,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              14,
              12,
              14,
              24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --------------------------------------------------
                // Back button
                // --------------------------------------------------
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 40,
                  ),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),

                const SizedBox(height: 2),

                // --------------------------------------------------
                // Logo
                // --------------------------------------------------
                Center(
                  child: Image.asset(
                    'assets/images/Logo_img.png',
                    width: 92,
                    height: 92,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 8),

                // --------------------------------------------------
                // Title
                // --------------------------------------------------
                Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Join the Future of Learning',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: AppColors.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // --------------------------------------------------
                // Subtitle
                // --------------------------------------------------
                Center(
                  child: Text(
                    'Start your learning journey with CoachSpace',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: AppColors.textLight,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                // Space between header and form
                const SizedBox(height: 38),

                // --------------------------------------------------
                // Full Name
                // --------------------------------------------------
                Text(
                  'Full Name',
                  style: GoogleFonts.inter(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 7),

                SignupCustomTextField(
                  controller: _nameController,
                  hintText: 'Jane Doe',
                  prefixIcon: Icons.person_outline_rounded,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 19),

                // --------------------------------------------------
                // Email
                // --------------------------------------------------
                Text(
                  'Email Address',
                  style: GoogleFonts.inter(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 7),

                SignupCustomTextField(
                  controller: _emailController,
                  hintText: 'jane@example.com',
                  prefixIcon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 19),

                // --------------------------------------------------
                // Password
                // --------------------------------------------------
                Text(
                  'Password',
                  style: GoogleFonts.inter(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 7),

                SignupCustomTextField(
                  controller: _passwordController,
                  hintText: '••••••••',
                  prefixIcon: Icons.lock_outline_rounded,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
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

                const SizedBox(height: 23),

                // --------------------------------------------------
                // Joining as
                // --------------------------------------------------
                Text(
                  'I am joining as',
                  style: GoogleFonts.inter(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 9),

                Row(
                  children: [
                    Expanded(
                      child: SignupRoleCard(
                        title: 'Student',
                        icon: Icons.school_rounded,
                        selected:
                        _selectedRole == UserRole.student,
                        onTap: () {
                          setState(() {
                            _selectedRole = UserRole.student;
                          });
                        },
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: SignupRoleCard(
                        title: 'Instructor',
                        icon: Icons.business_center_outlined,
                        selected:
                        _selectedRole == UserRole.instructor,
                        onTap: () {
                          setState(() {
                            _selectedRole = UserRole.instructor;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // --------------------------------------------------
                // Terms
                // --------------------------------------------------
                SignupTermsRichText(
                  agreed: _agreedToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreedToTerms = value;
                    });
                  },
                ),

                const SizedBox(height: 22),

                // --------------------------------------------------
                // Create Account
                // --------------------------------------------------
                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (previous, current) =>
                  previous is AuthRegisterLoading ||
                      current is AuthRegisterLoading,
                  builder: (context, state) {
                    final isLoading =
                    state is AuthRegisterLoading;

                    return MyButton(
                      text: isLoading
                          ? context.l10n.signupCreatingAccount
                          : 'Create Account  →',
                      onPressed:
                      isLoading ? () {} : _handleSignup,
                      color: AppColors.primary,
                      textColor: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      borderRadius: 10,
                      width: double.infinity,
                      height: 52,
                      padding: EdgeInsets.zero,
                    );
                  },
                ),

                const SizedBox(height: 17),

                // --------------------------------------------------
                // Security
                // --------------------------------------------------
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified_user_outlined,
                        color: AppColors.textLight,
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '100% encrypted and secure connection',
                        style: GoogleFonts.inter(
                          color: AppColors.textLight,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // --------------------------------------------------
                // Already have account - LAST
                // --------------------------------------------------
                const Divider(
                  color: AppColors.borderColor,
                  thickness: 0.8,
                ),

                const SizedBox(height: 18),

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
                            text: 'Already have an account? ',
                            style: GoogleFonts.inter(
                              color: AppColors.textLight,
                              fontSize: 11,
                            ),
                          ),
                          TextSpan(
                            text: 'Log in',
                            style: GoogleFonts.inter(
                              color: AppColors.primary,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}