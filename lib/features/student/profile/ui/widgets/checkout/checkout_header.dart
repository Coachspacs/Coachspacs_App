import 'package:flutter/material.dart';

import 'package:coach_space/core/widgets/back_title_header.dart';

/// Checkout screen header (back + title + bottom divider spacing).
class CheckoutHeader extends StatelessWidget {
  const CheckoutHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return BackTitleHeader(
      title: title,
      padding: const EdgeInsets.fromLTRB(12, 10, 16, 10),
    );
  }
}
