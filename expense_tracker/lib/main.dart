import 'package:expense_tracker/app_view.dart';
import 'package:expense_tracker/screens/home/views/HomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyAppView());
  }
}
