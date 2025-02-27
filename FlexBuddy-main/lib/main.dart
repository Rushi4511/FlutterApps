import 'package:firebase_core/firebase_core.dart';
import 'package:flex_buddy/view/abs/database/abs_beginner_database.dart';
import 'package:flex_buddy/view/login/login_screen.dart';
import 'package:flex_buddy/view/onboarding/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDnh27vfBlGZ6s6ZFS9SgrjNxR005UOZB8",
    appId: "1:199263803700:android:d6f50cf7840c785fd1ad61",
    messagingSenderId: "199263803700",
    projectId: "flexbuddy-13124",
  ));
  await LocalDatabase.initializeDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/login': (context) => const LoginScreen(),
        },
        debugShowCheckedModeBanner: false,
        title: 'FlexBuddy',
        home: SplashScreen());
  }
}
