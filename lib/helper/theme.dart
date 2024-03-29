import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF06D6A0),
    primary: const Color(0xFF06D6A0),
    onPrimary: const Color(0xFFFFB800),
    secondary: const Color(0xFF23302A),
    onSecondary: const Color(0xFFFCD462),
    background: const Color(0xFFFFFFFF),
    brightness: Brightness.light,
  ),
  
  textTheme: TextTheme(
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      color: Colors.black
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 20,
      color: Colors.black
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.w300,
      color: Colors.black
    ),
  )
);
ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF06D6A0),
    primary: const Color(0xFF06D6A0),
    onPrimary: const Color(0xFFFFB800),
    secondary: const Color(0xFFFFFFFF),
    onSecondary: const Color(0xFFFCD462),
    background: Colors.black54,
    brightness: Brightness.dark,
  ),
  
  textTheme: TextTheme(
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      color: Colors.white
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 20,
      color: Colors.white
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.w300,
      color: Colors.white
    ),
  )
);