import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Full-width green "Save Changes →" button used by the instructor
/// profile settings screens (payout, social links, security).
class InstructorSaveButton extends StatelessWidget {
  const InstructorSaveButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
          const Color(0xFF075E4D),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(11),
          ),
        ),
        child: Text(
          'Save Changes  →',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
