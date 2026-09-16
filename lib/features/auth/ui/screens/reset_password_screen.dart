import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/buttons.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
  });

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController =
  TextEditingController();

  final TextEditingController _confirmPasswordController =
  TextEditingController();

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // =====================================================
  // PASSWORD FIELD
  // =====================================================

  InputDecoration _passwordDecoration({
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return InputDecoration(
      hintText: hintText,

      hintStyle: GoogleFonts.inter(
        color: const Color(0xFFB4C0BC),
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),

      prefixIcon: const Icon(
        Icons.lock_outline_rounded,
        color: Color(0xFFB4C0BC),
        size: 18,
      ),

      suffixIcon: IconButton(
        onPressed: onToggle,
        icon: Icon(
          obscureText
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: const Color(0xFFB4C0BC),
          size: 18,
        ),
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
  // RESET PASSWORD
  // =====================================================

  void _resetPassword() {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      _showMessage('Please fill in both password fields.');
      return;
    }

    if (newPassword.length < 8) {
      _showMessage(
        'Password must be at least 8 characters.',
      );
      return;
    }

    if (newPassword != confirmPassword) {
      _showMessage(
        'Passwords do not match.',
      );
      return;
    }

    // ===================================================
    // UI ONLY FOR NOW
    // Backend will be connected later.
    // ===================================================

    _showSuccessDialog();
  }

  // =====================================================
  // MESSAGE
  // =====================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  // =====================================================
  // SUCCESS DIALOG
  // =====================================================

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),

          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              24,
              28,
              24,
              22,
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE2F3ED),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.primary,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  'Password Updated',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF073F38),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Your password has been updated successfully. You can now log in with your new password.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 10.5,
                    height: 1.6,
                    color: const Color(0xFF8A9995),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: MyButton(
                    text: 'Back to Login',
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.login,
                            (route) => false,
                      );
                    },
                    color: AppColors.primary,
                    textColor: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    borderRadius: 24,
                    width: double.infinity,
                    height: 48,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                'Reset your password',
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
                  'Create a new password for your Coach Space account.',
                  textAlign: TextAlign.center,

                  style: GoogleFonts.inter(
                    color: const Color(0xFF8A9995),
                    fontSize: 11,
                    height: 1.65,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // =================================================
              // NEW PASSWORD
              // =================================================

              Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                ),

                child: Text(
                  'New Password',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF31554E),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 7),

              SizedBox(
                height: 52,

                child: TextField(
                  controller: _newPasswordController,

                  obscureText: _obscureNewPassword,

                  textInputAction:
                  TextInputAction.next,

                  style: GoogleFonts.inter(
                    color: const Color(0xFF073F38),
                    fontSize: 12,
                  ),

                  decoration: _passwordDecoration(
                    hintText: 'Enter new password',

                    obscureText:
                    _obscureNewPassword,

                    onToggle: () {
                      setState(() {
                        _obscureNewPassword =
                        !_obscureNewPassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // =================================================
              // CONFIRM PASSWORD
              // =================================================

              Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                ),

                child: Text(
                  'Confirm Password',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF31554E),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 7),

              SizedBox(
                height: 52,

                child: TextField(
                  controller:
                  _confirmPasswordController,

                  obscureText:
                  _obscureConfirmPassword,

                  textInputAction:
                  TextInputAction.done,

                  style: GoogleFonts.inter(
                    color: const Color(0xFF073F38),
                    fontSize: 12,
                  ),

                  decoration: _passwordDecoration(
                    hintText:
                    'Confirm your password',

                    obscureText:
                    _obscureConfirmPassword,

                    onToggle: () {
                      setState(() {
                        _obscureConfirmPassword =
                        !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // =================================================
              // RESET BUTTON
              // =================================================

              MyButton(
                text: 'Reset Password',

                onPressed: _resetPassword,

                color: AppColors.primary,
                textColor: AppColors.white,

                fontSize: 13,
                fontWeight: FontWeight.w700,

                borderRadius: 26,

                width: double.infinity,
                height: 50,

                padding: EdgeInsets.zero,
              ),

              const SizedBox(height: 24),

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
                    'Back to login',
                    style: GoogleFonts.inter(
                      color: AppColors.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
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