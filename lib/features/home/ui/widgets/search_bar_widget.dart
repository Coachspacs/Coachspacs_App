import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  State<SearchBarWidget> createState() =>
      _SearchBarWidgetState();
}

class _SearchBarWidgetState
    extends State<SearchBarWidget> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = _focusNode.hasFocus;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        18,
        16,
        0,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isFocused
                ? const Color(0xFF075E4D)
                : const Color(0xFFD6E5E1),
            width: isFocused ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),

            const Icon(
              Icons.search_rounded,
              size: 21,
              color: Color(0xFF78908A),
            ),

            const SizedBox(width: 9),

            Expanded(
              child: TextField(
                focusNode: _focusNode,
                textInputAction: TextInputAction.search,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF344842),
                ),
                decoration: InputDecoration(
                  hintText:
                  context.l10n.homeSearchHint,
                  hintStyle: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF8A9995),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(
                right: 5,
              ),
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFF075E4D),
                borderRadius:
                BorderRadius.circular(11),
              ),
              child: const Icon(
                Icons.search_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}