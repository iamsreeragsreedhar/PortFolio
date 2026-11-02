import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Ultra-modern cyber dark palette
  static const bg = Color(0xFF07080E);
  static const surface = Color(0xFF0E111C);
  static const card = Color(0xFF141826);
  static const cardHover = Color(0xFF1B2135);
  static const glass = Color(0x14FFFFFF);
  static const glassBorder = Color(0x24FFFFFF);

  // Vivid neon accents
  static const accent = Color(0xFF00FFD1); // Neon Mint / Cyan
  static const accentPurple = Color(0xFF8B5CF6); // Electric Violet
  static const accentBlue = Color(0xFF38BDF8); // Cyber Sky Blue
  static const accentPink = Color(0xFFF43F5E); // Neon Rose
  static const accentAmber = Color(0xFFF59E0B); // Amber Glow
  static const accentGreen = Color(0xFF10B981); // Emerald Green

  // Refined typography colors
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF94A3B8);
  static const textMuted = Color(0xFF64748B);
  static const border = Color(0xFF22293F);
  static const borderLight = Color(0xFF313B59);

  // Gradient presets
  static const LinearGradient cyberGradient = LinearGradient(
    colors: [accent, accentPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient neonBluePurple = LinearGradient(
    colors: [accentBlue, accentPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient emeraldGradient = LinearGradient(
    colors: [Color(0xFF059669), accentGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

ThemeData appTheme() {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent,
      secondary: AppColors.accentPurple,
      surface: AppColors.surface,
    ),
    textTheme: GoogleFonts.spaceGroteskTextTheme(ThemeData.dark().textTheme),
  );
}
