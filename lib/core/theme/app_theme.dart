import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final TextTheme _textTheme = GoogleFonts.outfitTextTheme();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6C63FF), // Example primary color
        brightness: Brightness.light,
      ),
      textTheme: _textTheme,
      scaffoldBackgroundColor: Colors.white,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6C63FF),
        brightness: Brightness.dark,
      ),
      textTheme: _textTheme,
      scaffoldBackgroundColor: const Color(0xFF121212),
    );
  }
}
