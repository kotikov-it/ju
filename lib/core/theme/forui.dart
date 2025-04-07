import 'dart:ui';

import 'package:flutter/material.dart';

class _ForuiColors {
  const _ForuiColors._(); // Private constructor

  // --- Primary (Beispiel: Blautöne) ---
  static const Color primary500 =
      Color(0xFF007AFF); // Typisches leuchtendes Blau
  static const Color primary600 = Color(0xFF0070E8);
  static const Color primary400 =
      Color(0xFF3395FF); // Etwas heller für Dark Mode

  // --- Neutrals / Gray ---
  static const Color gray900 = Color(0xFF18191A); // Sehr dunkel (Dark Bg)
  static const Color gray800 = Color(0xFF212529); // Dunkel (Dark Surface/Text)
  static const Color gray700 =
      Color(0xFF343A40); // Dunkelgrau (Dark Input Fill)
  static const Color gray600 = Color(0xFF495057); // Mittelgrau (Dark Border)
  static const Color gray500 = Color(0xFF6C757D);
  static const Color gray400 = Color(0xFFADB5BD);
  static const Color gray300 = Color(0xFFCED4DA); // Hellgrau (Light Border)
  static const Color gray200 = Color(0xFFDEE2E6); // Helleres Grau
  static const Color gray100 =
      Color(0xFFF1F3F5); // Sehr hell (Light Input Fill)
  static const Color gray50 = Color(0xFFF8F9FA); // Fast Weiß (Light Bg Alt)

  // --- Background & Surface ---
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = gray900; // #18191A
  static const Color surfaceDark = gray800; // #212529

  // --- Text & On-Colors ---
  static const Color textLight = gray800; // #212529
  static const Color textDark = gray100; // #F1F3F5 (oder gray50)
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onPrimaryDark =
      Color(0xFFFFFFFF); // Oder ggf. ein dunkler Ton

  // --- Functional Colors (Beispiele) ---
  static const Color errorLight = Color(0xFFDC3545); // Rot
  static const Color errorDark = Color(0xFFE57373); // Helleres Rot
  static const Color successLight = Color(0xFF198754); // Grün
  static const Color successDark = Color(0xFF81C784); // Helleres Grün

  // --- Border & Input ---
  static const Color borderLight = gray300; // #CED4DA
  static const Color borderDark = gray600; // #495057
  static const Color inputFillLight = gray50; // #F8F9FA
  static const Color inputFillDark = gray700; // #343A40
}

class AppTheme {
  // --- Basiskonfigurationen ---
  static const double _borderRadius = 8.0; // Typischer Radius für forui
  static const String _fontFamily =
      ''; // Hier 'Inter' eintragen, wenn via google_fonts verfügbar

  // --- Helles Theme (White Theme - basierend auf forui) ---
  static ThemeData get lightTheme {
    final baseTheme = ThemeData.light(useMaterial3: true);

    return baseTheme.copyWith(
      brightness: Brightness.light,
      primaryColor: _ForuiColors.primary500,
      // Definiere das Farbschema basierend auf forui-Farben
      colorScheme: const ColorScheme.light(
        primary: _ForuiColors.primary500,
        // primaryVariant: _ForuiColors.primary600, // Ältere Property
        secondary: _ForuiColors.primary500,
        // Oft wird Primary auch als Secondary genutzt
        // secondaryVariant: _ForuiColors.primary600, // Ältere Property
        background: _ForuiColors.backgroundLight,
        surface: _ForuiColors.surfaceLight,
        error: _ForuiColors.errorLight,
        onPrimary: _ForuiColors.onPrimaryLight,
        onSecondary: _ForuiColors.onPrimaryLight,
        // Wenn secondary = primary
        onBackground: _ForuiColors.textLight,
        onSurface: _ForuiColors.textLight,
        onError: _ForuiColors.onPrimaryLight,
        // Weiß auf Rot
        surfaceVariant: _ForuiColors.gray100,
        // Für leicht abgesetzte Oberflächen
        outline: _ForuiColors.borderLight, // Standard-Randfarbe
      ),
      scaffoldBackgroundColor: _ForuiColors.backgroundLight,
      // Setze die Schriftfamilie, falls verfügbar
      // fontFamily: _fontFamily.isNotEmpty ? _fontFamily : null,
      appBarTheme: AppBarTheme(
        elevation: 0,
        // Flacher Stil
        backgroundColor: _ForuiColors.surfaceLight,
        foregroundColor: _ForuiColors.textLight,
        iconTheme: const IconThemeData(color: _ForuiColors.gray600),
        // Etwas dezenter
        titleTextStyle: baseTheme.textTheme.titleLarge?.copyWith(
          color: _ForuiColors.textLight,
          fontWeight: FontWeight.w600,
          // fontFamily: _fontFamily.isNotEmpty ? _fontFamily : null,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _ForuiColors.inputFillLight,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        // Subtile Border im Normalzustand
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide:
              const BorderSide(color: _ForuiColors.borderLight, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide:
              const BorderSide(color: _ForuiColors.borderLight, width: 1.0),
        ),
        // Primärfarbe als Fokus-Indikator
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide:
              const BorderSide(color: _ForuiColors.primary500, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide:
              const BorderSide(color: _ForuiColors.errorLight, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide:
              const BorderSide(color: _ForuiColors.errorLight, width: 1.5),
        ),
        labelStyle: const TextStyle(color: _ForuiColors.gray600),
        hintStyle: const TextStyle(color: _ForuiColors.gray400),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: _ForuiColors.primary500,
        foregroundColor: _ForuiColors.onPrimaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        // Angepasstes Padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight
                .w600 /*, fontFamily: _fontFamily.isNotEmpty ? _fontFamily : null*/),
        elevation: 0,
        // Flacher Stil, wie oft bei forui
        shadowColor: Colors.transparent,
      ).copyWith(
        // Leichter Effekt beim Drücken
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return _ForuiColors.primary600.withOpacity(0.2);
            }
            return null; // Defer to the default
          },
        ),
      )),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _ForuiColors.primary500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          textStyle: const TextStyle(
              fontWeight: FontWeight
                  .w600 /*, fontFamily: _fontFamily.isNotEmpty ? _fontFamily : null*/),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
        foregroundColor: _ForuiColors.primary500,
        side: const BorderSide(color: _ForuiColors.borderLight, width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(
            fontWeight: FontWeight
                .w600 /*, fontFamily: _fontFamily.isNotEmpty ? _fontFamily : null*/),
      ).copyWith(
              // Border wird dicker/farbiger bei Hover/Press
              side: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed) ||
            states.contains(MaterialState.hovered)) {
          return const BorderSide(color: _ForuiColors.primary500, width: 1.5);
        }
        return const BorderSide(color: _ForuiColors.borderLight, width: 1.0);
      }))),
      cardTheme: CardTheme(
        elevation: 0, // Keine Schatten für Karten
        color: _ForuiColors.surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          // Konsistenter Radius
          side: const BorderSide(
              color: _ForuiColors.borderLight, width: 1.0), // Sichtbare Border
        ),
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 0),
      ),
      dividerTheme: const DividerThemeData(
        color: _ForuiColors.borderLight,
        thickness: 1.0,
      ),
      // Füge hier weitere spezifische forui-Stile für andere Komponenten hinzu
    );
  }

  // --- Dunkles Theme (Dark Theme - basierend auf forui) ---
  static ThemeData get darkTheme {
    final baseTheme = ThemeData.dark(useMaterial3: true);

    return baseTheme.copyWith(
      brightness: Brightness.dark,
      primaryColor: _ForuiColors.primary400,
      // Hellerer Primärton für Dark Mode
      colorScheme: const ColorScheme.dark(
        primary: _ForuiColors.primary400,
        // Heller
        // primaryVariant: _ForuiColors.primary500,
        secondary: _ForuiColors.primary400,
        // Heller
        // secondaryVariant: _ForuiColors.primary500,
        background: _ForuiColors.backgroundDark,
        surface: _ForuiColors.surfaceDark,
        error: _ForuiColors.errorDark,
        onPrimary: _ForuiColors.onPrimaryDark,
        // Dunkel auf hellem Primärton? Oft weiß.
        onSecondary: _ForuiColors.onPrimaryDark,
        onBackground: _ForuiColors.textDark,
        onSurface: _ForuiColors.textDark,
        onError: _ForuiColors.gray900,
        // Dunkel auf hellem Rot
        surfaceVariant: _ForuiColors.gray800,
        // Für leicht abgesetzte Oberflächen
        outline: _ForuiColors.borderDark, // Standard-Randfarbe im Dark Mode
      ),
      scaffoldBackgroundColor: _ForuiColors.backgroundDark,
      // fontFamily: _fontFamily.isNotEmpty ? _fontFamily : null,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: _ForuiColors.surfaceDark,
        // Dunkle Oberfläche
        foregroundColor: _ForuiColors.textDark,
        iconTheme: const IconThemeData(color: _ForuiColors.gray400),
        // Heller als Text
        titleTextStyle: baseTheme.textTheme.titleLarge?.copyWith(
          color: _ForuiColors.textDark,
          fontWeight: FontWeight.w600,
          // fontFamily: _fontFamily.isNotEmpty ? _fontFamily : null,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _ForuiColors.inputFillDark,
        // Dunklerer Input-Hintergrund
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide:
              const BorderSide(color: _ForuiColors.borderDark, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide:
              const BorderSide(color: _ForuiColors.borderDark, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: const BorderSide(
              color: _ForuiColors.primary400, width: 1.5), // Heller Primärfokus
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide:
              const BorderSide(color: _ForuiColors.errorDark, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide:
              const BorderSide(color: _ForuiColors.errorDark, width: 1.5),
        ),
        labelStyle: const TextStyle(color: _ForuiColors.gray400),
        hintStyle: const TextStyle(color: _ForuiColors.gray500),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: _ForuiColors.primary400,
        // Hellerer Primärton
        foregroundColor: _ForuiColors.onPrimaryDark,
        // Heller Text (oft weiß)
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight
                .w600 /*, fontFamily: _fontFamily.isNotEmpty ? _fontFamily : null*/),
        elevation: 0,
        shadowColor: Colors.transparent,
      ).copyWith(
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return _ForuiColors.primary500
                  .withOpacity(0.3); // Dunklerer Effekt auf hellem Button
            }
            return null;
          },
        ),
      )),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _ForuiColors.primary400, // Hellerer Primärton
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          textStyle: const TextStyle(
              fontWeight: FontWeight
                  .w600 /*, fontFamily: _fontFamily.isNotEmpty ? _fontFamily : null*/),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
        foregroundColor: _ForuiColors.primary400,
        // Heller Text
        side: const BorderSide(color: _ForuiColors.borderDark, width: 1.0),
        // Dunkle Border
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(
            fontWeight: FontWeight
                .w600 /*, fontFamily: _fontFamily.isNotEmpty ? _fontFamily : null*/),
      ).copyWith(side: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed) ||
            states.contains(MaterialState.hovered)) {
          return const BorderSide(
              color: _ForuiColors.primary400, width: 1.5); // Heller Fokus
        }
        return const BorderSide(color: _ForuiColors.borderDark, width: 1.0);
      }))),
      cardTheme: CardTheme(
        elevation: 0,
        color: _ForuiColors.surfaceDark, // Dunkle Oberfläche
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          side: const BorderSide(
              color: _ForuiColors.borderDark, width: 1.0), // Dunkle Border
        ),
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 0),
      ),
      dividerTheme: const DividerThemeData(
        color: _ForuiColors.borderDark,
        thickness: 1.0,
      ),
      // Füge hier weitere spezifische forui-Stile für andere Komponenten hinzu
    );
  }
}
