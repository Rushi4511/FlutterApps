import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_buddy/bottom_navigation.dart';
import 'package:flex_buddy/controller/sessions.dart';
import 'package:flex_buddy/view/details_screen/gender_screen.dart';
import 'package:flex_buddy/view/login/login_screen.dart';
import 'package:flex_buddy/view/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  late bool isInfoFilled;

  @override
  Widget build(BuildContext context) {
    navigateToOnboarding(context);
    return Scaffold(
      backgroundColor: const Color(0x00000fff),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 350, left: 100),
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/svg/logo.svg', // Path to the SVG file
                  width: 220,
                  height: 110,
                ),
                Positioned(
                  right: 25,
                  top: 5,
                  child: Image.asset(
                    'assets/images/lift.png',
                    height: 100,
                    width: 100,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 90),
            child: Row(
              children: [
                Text(
                  "Flex",
                  style: GoogleFonts.poppins(
                    fontStyle: FontStyle.italic,
                    color: const Color.fromRGBO(226, 241, 99, 1),
                    fontWeight: FontWeight.w800,
                    fontSize: 42,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  "Buddy",
                  style: GoogleFonts.poppins(
                    fontStyle: FontStyle.italic,
                    color: const Color.fromRGBO(226, 241, 99, 1),
                    fontSize: 44,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateToOnboarding(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
      await SessionData.getSessionData();

      await getIsInfoFilled(SessionData.emailId);

      if (SessionData.isFirstTime) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const OnboardingScreens(),
        ));
        log("Onboarding Screen");
      } else if (SessionData.isLogin) {
        if (isInfoFilled) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const CustomBottomNavigationBar(),
          ));

          log("HomeScreen Screen");
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const GenderScreen(),
          ));
          log("Gender Details Screen");
        }
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
        log("Login Screen");
      }
    });
  }

  Future<void> getIsInfoFilled(String? email) async {
    if (email == null || email.isEmpty) {
      log('Email is null or empty');
      return;
    }

    try {
      final firestore = FirebaseFirestore.instance;
      DocumentSnapshot docSnapshot =
          await firestore.collection('Users').doc(email).get();

      if (docSnapshot.exists) {
        isInfoFilled = docSnapshot.get('isInfoFilled') ?? false;
      } else {
        log('Document does not exist');
        isInfoFilled = false;
      }
    } catch (e) {
      log('Error fetching isInfoFilled: $e');
      isInfoFilled = false;
    }
  }
}
