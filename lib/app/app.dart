import 'package:flutter/material.dart';
import 'package:tut_app/presentation/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp._internal(); // private named constructor

  static const MyApp _instance = MyApp._internal(); // singleton instance

  factory MyApp() => _instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
    );
  }
}
