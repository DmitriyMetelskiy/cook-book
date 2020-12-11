import 'package:flutter/material.dart';
import 'package:cook_book/ui/screens/login.dart';
import 'package:cook_book/ui/screens/home.dart';
import 'package:cook_book/ui/theme.dart';

class CookBookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cook Book',
      theme: buildTheme(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}