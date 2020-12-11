import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cook_book/app.dart';
import 'package:cook_book/state_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new StateWidget(
    child: new CookBookApp(),
  ));
}