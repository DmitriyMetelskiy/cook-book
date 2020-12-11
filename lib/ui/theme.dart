import 'package:flutter/material.dart';

ThemeData buildTheme() {
  TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      headline4: base.headline4.copyWith(
        fontFamily: 'Niconne',
        fontSize: 40.0,
        color: const Color(0xFF807A6B),
      ),
      headline5: base.headline5.copyWith(
        fontFamily: 'Courgette',
        fontSize: 20.0,
        color: const Color(0xFF807A6B),
      ),
      caption: base.caption.copyWith(
        color: const Color(0xFFCCC5AF),
        fontSize: 15.0,
      ),
    );
  }

  final ThemeData base = ThemeData.light();

  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryColor: const Color(0xFFFFF8E1),
    indicatorColor: const Color(0xFF807A6B),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    accentColor: const Color(0xFFFFF8E1),
    iconTheme: IconThemeData(
      color: const Color(0xFFCCC5AF),
      size: 20.0,
    ),
    buttonColor: Colors.white,
    backgroundColor: Colors.white,
    tabBarTheme: base.tabBarTheme.copyWith(
      labelColor: const Color(0xFF807A6B),
      unselectedLabelColor: const Color(0xFFCCC5AF),
    ),
  );
}