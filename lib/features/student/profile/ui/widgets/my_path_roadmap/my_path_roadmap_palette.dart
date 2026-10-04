import 'package:flutter/material.dart';

/// Design tokens cloned from the web `/student/my-path` roadmap screen so the
/// mobile rendering matches pixel-for-pixel as closely as Flutter allows.
abstract final class MyPathRoadmapColors {
  // ---- Header card -------------------------------------------------------
  static const Color headerDarkTop = Color(0xFF0C473A);
  static const Color headerDarkMid = Color(0xFF0F5244);
  static const Color headerDarkBottom = Color(0xFF072A22);
  static const Color headerBorder = Color(0x4D10B981); // emerald-500/30
  static const Color mint = Color(0xFF38E09D);
  static const Color teal = Color(0xFF45D1B4);
  static const Color headerTextSoft = Color(0xFFD1FAE5); // emerald-100

  // ---- Canvas (mobile rail) ----------------------------------------------
  static const Color canvasTop = Color(0xFFEBF7F2);
  static const Color canvasMid = Color(0xFFF2FAF6);
  static const Color canvasBottom = Color(0xFFE5F5EE);
  static const Color canvasBorder = Color(0x806EE7B7); // emerald-300/80
  static const Color canvasDot = Color(0xFF0F5244);

  // ---- Rail badges -------------------------------------------------------
  static const Color badgeCurrentTop = Color(0xFF0F5244);
  static const Color badgeCurrentMid = Color(0xFF146654);
  static const Color badgeCurrentBottom = Color(0xFF1E8A73);
  static const Color badgePendingTop = Color(0xFFE6F7F0);
  static const Color badgePendingMid = Color(0xFFD1FAE5);
  static const Color badgePendingBottom = Color(0xFFB8F0DA);
  static const Color badgeDoneTop = Color(0xFF059669); // emerald-600
  static const Color badgeSkipped = Color(0xFFE2E8F0); // slate-200
  static const Color badgeLastTop = Color(0xFF0F5244);
  static const Color badgeLastBottom = Color(0xFF1A7763);

  // ---- Stage cards -------------------------------------------------------
  static const Color cardBorderActive = Color(0xE610B981); // emerald-500/90
  static const Color stageChipText = Color(0xFF065F46); // emerald-800
  static const Color amber400 = Color(0xFFFBBF24);
  static const Color amberChipBg = Color(0xFFFEF3C7); // amber-100
  static const Color amberChipText = Color(0xFF78350F); // amber-900
  static const Color amberChipBorder = Color(0x5CFBBF24); // amber-200/70
  static const Color slateTitle = Color(0xFF0F172A);
  static const Color slateBody = Color(0xFF475569);
  static const Color slateSubtle = Color(0xFF94A3B8);
  static const Color cardBtnTop = Color(0xFF0F5244);
  static const Color cardBtnBottom = Color(0xFF146654);
}
