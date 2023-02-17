import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class Themes {
  static final ThemeData kLightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: kWhiteColor,
    ),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: kPrimaryColor,
      backgroundColor: kWhiteColor,
      brightness:
          Brightness.light, // tells that the background color must be white
    ),
    scaffoldBackgroundColor: kWhiteColor,
    primaryColor: kPrimaryColor, // for changing the color of the Buttons
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: kWhiteColor,
      elevation: 0,
      unselectedItemColor: kDarkColor,
      selectedItemColor: kPrimaryColor,
      type: BottomNavigationBarType.fixed,

    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(),
      bodyMedium: GoogleFonts.poppins(),
      bodySmall: GoogleFonts.poppins(),
      displayLarge: GoogleFonts.poppins(),
      displayMedium: GoogleFonts.poppins(),
      displaySmall: GoogleFonts.poppins(),
      labelLarge: GoogleFonts.poppins(),
      labelMedium: GoogleFonts.poppins(),
      labelSmall: GoogleFonts.poppins(),
      titleLarge: GoogleFonts.poppins(),
      titleMedium: GoogleFonts.poppins(),
      titleSmall: GoogleFonts.poppins(),
    ),
  );

  static final ThemeData kDarkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: kDarkColor,
    ),
    colorScheme: ColorScheme.fromSwatch(
      backgroundColor: kDarkColor,
      brightness:
          Brightness.dark, // tells that the background color must be dark
    ),
    scaffoldBackgroundColor: kDarkColor,
    primaryColor: kPrimaryColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: kDarkColor,
      elevation: 0,
      unselectedItemColor: kWhiteColor,
      selectedItemColor: kPrimaryColor,
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(),
      bodyMedium: GoogleFonts.poppins(),
      bodySmall: GoogleFonts.poppins(),
      displayLarge: GoogleFonts.poppins(),
      displayMedium: GoogleFonts.poppins(),
      displaySmall: GoogleFonts.poppins(),
      labelLarge: GoogleFonts.poppins(),
      labelMedium: GoogleFonts.poppins(),
      labelSmall: GoogleFonts.poppins(),
      titleLarge: GoogleFonts.poppins(),
      titleMedium: GoogleFonts.poppins(),
      titleSmall: GoogleFonts.poppins(),
    ),
  );
}
