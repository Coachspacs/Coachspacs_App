import 'package:flutter/material.dart';

class CatalogSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const CatalogSearchBar({
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search courses...',
        hintStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade500,
        ),
        prefixIcon: const Icon(
          Icons.search,
          size: 19,
          color: Color(0xFF6E8580),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(
            color: Color(0xFFD8E4E1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(
            color: Color(0xFFD8E4E1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(
            color: Color(0xFF075E4D),
          ),
        ),
      ),
    );
  }
}