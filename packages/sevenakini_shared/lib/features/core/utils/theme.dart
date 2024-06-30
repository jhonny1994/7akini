import 'package:flutter/material.dart';

@immutable
class AppTheme {
  const AppTheme._();
  static final lightTheme = ThemeData(
    primaryColor: const Color(0xff2596be),
    useMaterial3: false,
    colorScheme: const ColorScheme.light().copyWith(
      primary: const Color(0xff2596be),
      secondary: const Color(0xffF9A826),
      error: const Color(0xffcf5d3e),
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: Color(0xff2596be),
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(
      color: Color(0xfff1ece4),
    ),
  );
  static final darkTheme = ThemeData(
    primaryColor: const Color(0xff2596be),
    useMaterial3: false,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: const Color(0xff2596be),
      secondary: const Color(0xffF9A826),
      error: const Color(0xffcf5d3e),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(
      color: Color(0xfff1ece4),
    ),
  );
}
