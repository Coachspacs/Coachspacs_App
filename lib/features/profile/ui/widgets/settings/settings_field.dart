import 'package:flutter/material.dart';

class SettingsField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool showChange;

  const SettingsField({
    super.key,
    required this.label,
    required this.controller,
    this.showChange = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),

            if (showChange)
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Change',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0B624F),
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: 7),

        TextField(
          controller: controller,
          style: const TextStyle(
            fontSize: 13,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(
                color: Color(0xFFDDE6E3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(
                color: Color(0xFFDDE6E3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(
                color: Color(0xFF0B624F),
              ),
            ),
          ),
        ),
      ],
    );
  }
}