import 'package:flutter/material.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';

class MyPathHoursHeader extends StatelessWidget {
  const MyPathHoursHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            l10n.myPathHoursQuestion,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1.2,
              color: Color(0xFF172033),
            ),
          ),
        ),

        const SizedBox(height: 7),

        SizedBox(
          width: double.infinity,
          child: Text(
            l10n.myPathHoursSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              height: 1.55,
              color: Color(0xFF657774),
            ),
          ),
        ),
      ],
    );
  }
}