import 'package:flutter/material.dart';

class AppTemas {
  // light theme
  static final light = ThemeData(
    primaryColor: const Color.fromARGB(255, 255, 196, 34),
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      )
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 255, 196, 34),
      primary: const Color.fromARGB(255, 255, 196, 34),
      brightness: Brightness.light,
      surface: Colors.white,
    ),
    cardColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color.fromARGB(255, 255, 196, 34),
      unselectedItemColor: Colors.grey,
    ),
  );

  // dark theme
  static final dark = ThemeData(
    primaryColor: const Color.fromARGB(255, 255, 196, 34),
    scaffoldBackgroundColor: const Color(0xFF121212),
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white,
      )
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 255, 196, 34),
      primary: const Color.fromARGB(255, 255, 196, 34),
      brightness: Brightness.dark,
      surface: const Color(0xFF121212),
    ),
    cardColor: const Color(0xFF1E1E1E),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: Color.fromARGB(255, 255, 196, 34),
      unselectedItemColor: Colors.grey,
    ),
  );
}