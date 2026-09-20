import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/routes.dart';

class HomeHeroSection extends StatefulWidget {
  const HomeHeroSection({
    super.key,
  });

  @override
  State<HomeHeroSection> createState() =>
      _HomeHeroSectionState();
}

class _HomeHeroSectionState
    extends State<HomeHeroSection> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _openCatalog() {
    _focusNode.unfocus();

    Navigator.pushNamed(
      context,
      AppRoutes.catalog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        0,
      ),
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        18,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F8F2),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFC7EEE2),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          // =================================================
          // WELCOME BADGE
          // =================================================

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFD2F1E7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              context.l10n.homeWelcome,
              style: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: .4,
                color: const Color(0xFF075E4D),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // =================================================
          // TITLE
          // =================================================

          Text(
            context.l10n.homeHeroTitle,
            style: GoogleFonts.inter(
              fontSize: 20,
              height: 1.3,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF073F38),
            ),
          ),

          const SizedBox(height: 14),

          // =================================================
          // SEARCH
          // =================================================

          Container(
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFD8E8E3),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 14),

                const Icon(
                  Icons.search_rounded,
                  size: 21,
                  color: Color(0xFF879A95),
                ),

                const SizedBox(width: 9),

                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    textInputAction:
                    TextInputAction.search,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: const Color(0xFF344842),
                    ),
                    decoration: InputDecoration(
                      hintText:
                      context.l10n.homeSearchHint,
                      hintStyle: GoogleFonts.inter(
                        fontSize: 11,
                        color: const Color(0xFF9AA7A3),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    onSubmitted: (_) {
                      _openCatalog();
                    },
                  ),
                ),

                GestureDetector(
                  onTap: _openCatalog,
                  child: Container(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}