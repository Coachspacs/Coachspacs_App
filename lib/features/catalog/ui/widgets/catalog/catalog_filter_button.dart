import 'package:flutter/material.dart';

class CatalogFilterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CatalogFilterButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.tune,
        size: 17,
      ),
      label: const Text(
        'Filters',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF075E4D),
        backgroundColor: Colors.white,
        side: const BorderSide(
          color: Color(0xFFD8E4E1),
        ),
        minimumSize: const Size(
          0,
          44,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11),
        ),
      ),
    );
  }
}