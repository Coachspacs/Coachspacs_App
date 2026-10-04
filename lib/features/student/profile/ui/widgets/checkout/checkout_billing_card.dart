import 'package:flutter/material.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/features/student/profile/ui/widgets/checkout/checkout_field_label.dart';
import 'package:coach_space/features/student/profile/ui/widgets/checkout/checkout_text_field.dart';

/// Billing information card (full name + email inputs).
class CheckoutBillingCard extends StatelessWidget {
  const CheckoutBillingCard({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.fullNameValidator,
    required this.emailValidator,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final String? Function(String?) fullNameValidator;
  final String? Function(String?) emailValidator;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CheckoutFieldLabel(label: l10n.checkoutFullName),
          const SizedBox(height: 6),
          CheckoutTextField(
            controller: fullNameController,
            hintText: l10n.checkoutFullName,
            icon: Icons.person_outline_rounded,
            validator: fullNameValidator,
          ),
          const SizedBox(height: 12),
          CheckoutFieldLabel(label: l10n.checkoutEmail),
          const SizedBox(height: 6),
          CheckoutTextField(
            controller: emailController,
            hintText: l10n.checkoutEmail,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: emailValidator,
          ),
        ],
      ),
    );
  }
}
