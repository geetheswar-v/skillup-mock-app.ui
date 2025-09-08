import 'package:flutter/material.dart';

class AppColors {
  // Red brand palette (darkest -> lightest)
  static const darkest = Color(0xFFB00020); // deep red
  static const dark = Color(0xFFCF2B2B);
  static const medium = Color(0xFFE76868);
  static const light = Color(0xFFF6B3B3);
  static const lightest = Color(0xFFFDEDEE);
}

ThemeData buildLightTheme() {
  final base = ThemeData.light(useMaterial3: false);
  return base.copyWith(
    primaryColor: AppColors.darkest,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.darkest,
      primaryContainer: AppColors.light,
      secondary: AppColors.dark,
      surface: Colors.white,
      onPrimary: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0.5,
      centerTitle: false,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkest,
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.darkest,
  side: const BorderSide(color: AppColors.darkest),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: AppColors.medium),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: AppColors.light),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: AppColors.darkest, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    chipTheme: base.chipTheme.copyWith(
  selectedColor: AppColors.light,
      backgroundColor: AppColors.lightest,
      labelStyle: const TextStyle(color: Colors.black),
      secondarySelectedColor: AppColors.medium,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.darkest,
      unselectedItemColor: Colors.black54,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.5,
      margin: const EdgeInsets.all(8),
    ),
  );
}

ThemeData buildDarkTheme() {
  final base = ThemeData.dark(useMaterial3: false);
  return base.copyWith(
    // In dark theme, use the lighter red to improve contrast
    primaryColor: AppColors.medium,
    scaffoldBackgroundColor: const Color(0xFF0B0E11),
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.medium,
      secondary: AppColors.light,
      surface: const Color(0xFF101317),
      onPrimary: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.medium,
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.light,
        side: const BorderSide(color: AppColors.light),
        shape: const StadiumBorder(),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1A1F25),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF151A20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.5,
    ),
  );
}
