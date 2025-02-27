// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_buddy/bottom_navigation.dart';
import 'package:flex_buddy/controller/sessions.dart';
import 'package:flex_buddy/custom_snackbar.dart';
import 'package:flex_buddy/view/details_screen/gender_screen.dart';
import 'package:flex_buddy/view/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  final bool? directRegister = false;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late bool isInfoFilled;

  Future<void> getIsInfoFilled(String email) async {
    try {
      final firestore = FirebaseFirestore.instance;
      DocumentSnapshot docSnapshot =
          await firestore.collection('Users').doc(email).get();

      if (docSnapshot.exists) {
        setState(() {
          isInfoFilled = docSnapshot.get('isInfoFilled');
        });
      } else {
        log('Document does not exist');
        setState(() {});
      }
    } catch (e) {
      log('Error fetching isInfoFilled: $e');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Adjusts UI for keyboard
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Text(
                "Log In",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: const Color.fromRGBO(226, 241, 99, 1),
                ),
              ),
              const SizedBox(height: 35,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 55),
              Container(
                padding: const EdgeInsets.all(14.0),
                // color: const Color.fromRGBO(179, 160, 255, 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: GoogleFonts.leagueSpartan(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 15),
                      decoration: InputDecoration(
                        hintText: "Enter your Email ",
                        hintStyle: GoogleFonts.leagueSpartan(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(179, 160, 255, 1),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        filled: true,
                        fillColor: Colors.white12,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Password",
                      style: GoogleFonts.leagueSpartan(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 15),
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          child: Icon(
                            color: Colors.white54,
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onTap: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                        hintText: "Enter your password ",
                        hintStyle: GoogleFonts.leagueSpartan(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(179, 160, 255, 1),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        filled: true,
                        fillColor: Colors.white12,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forget password",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ClipRRect(
                borderRadius: BorderRadius.circular(10), // Rounded corners
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 5, sigmaY: 5), // Adjust blur intensity
                  child: ElevatedButton(
                    onPressed: () async {
                      if (emailController.text.trim().isNotEmpty &&
                          passwordController.text.trim().isNotEmpty) {
                        try {
                          UserCredential userCredential =
                              await _firebaseAuth.signInWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                          await SessionData.storeSessionData(
                              isLogin: true,
                              emailId: userCredential.user!.email!,
                              isFirstTime: false);
                          await SessionData.getSessionData();
                          // Show success snackbar
                          CustomSnackbar.showCustomSnackbar(
                            message: "User Logged In Successfully",
                            context: context,
                          );

                          await getIsInfoFilled(emailController.text.trim());

                          if (isInfoFilled) {
                            log("info is filled go to homescreen");
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) =>
                                  const CustomBottomNavigationBar(),
                            ));
                          } else {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const GenderScreen(),
                            ));

                            log("info is not filled go to details screen");
                          }
                        } on FirebaseAuthException catch (error) {
                          CustomSnackbar.showCustomSnackbar(
                            message: error.message ?? "An error occurred",
                            context: context,
                          );
                        } catch (e) {
                          log("Unexpected error: $e");
                          CustomSnackbar.showCustomSnackbar(
                            message: "An unexpected error occurred",
                            context: context,
                          );
                        }
                      } else {
                        CustomSnackbar.showCustomSnackbar(
                          message: "Please fill out all fields",
                          context: context,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          const Size(165, 45), // Width and height of the button
                      backgroundColor: Colors.white
                          .withOpacity(0.3), // Semi-transparent background
                      elevation: 1, // Remove shadow if desired
                    ),
                    child: Text(
                      "Log In",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "or sign up with",
                style: GoogleFonts.leagueSpartan(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/Google.png",
                    height: 40,
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    "assets/images/Fg.png",
                    height: 40,
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    "assets/images/Fb.png",
                    height: 40,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                "Don't have an Account?",
                style: GoogleFonts.leagueSpartan(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SignupScreen(),
                  ));
                },
                child: Text(
                  "Signup",
                  style: GoogleFonts.leagueSpartan(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: const Color.fromRGBO(220, 220, 99, 1),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
