import 'package:flutter/material.dart';
import 'package:petcare_app_ui/screens/screen1.dart';
import 'package:petcare_app_ui/screens/screen2.dart';
import 'package:petcare_app_ui/screens/screen3.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: Screen1());
  }
}
