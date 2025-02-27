import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_buddy/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool passwordVisible = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Create Account",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: const Color.fromRGBO(226, 241, 99, 1),
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: Color.fromRGBO(226, 241, 99, 1),
              size: 25,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: GoogleFonts.leagueSpartan(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: nameController,
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 15),
                        decoration: InputDecoration(
                          hintText: "Enter your Name ",
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
                      const SizedBox(height: 15),
                      Text(
                        "Confirm Password",
                        style: GoogleFonts.leagueSpartan(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: confirmPasswordController,
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
                          hintText: "Confirm password ",
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
                        "Mobile Number",
                        style: GoogleFonts.leagueSpartan(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: mobileNoController,
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 15),
                        // obscureText: !passwordVisible,
                        decoration: InputDecoration(
                          hintText: "Enter your Mobile No.",
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 5, sigmaY: 5), // Adjust blur intensity
                    child: ElevatedButton(
                      onPressed: () async {
                        if (nameController.text.trim().isNotEmpty &&
                            emailController.text.trim().isNotEmpty &&
                            mobileNoController.text.trim().isNotEmpty &&
                            passwordController.text.trim().isNotEmpty &&
                            confirmPasswordController.text.trim().isNotEmpty) {
                          try {
                            // Create user with email and password
                            UserCredential userCredential = await _firebaseAuth
                                .createUserWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                            log("UserCredentials: $userCredential");

                            // Prepare signup data
                            Map<String, dynamic> signupData = {
                              "name": nameController.text.trim(),
                              "email": emailController.text.trim(),
                              "password": passwordController.text.trim(),
                              "mobileNo": mobileNoController.text.trim(),
                              "isInfoFilled": false,
                            };

                            // Store data in Firestore with email as document ID
                            await FirebaseFirestore.instance
                                .collection("Users")
                                .doc(signupData['email'])
                                .set(signupData);

                            // Show success snackbar
                            CustomSnackbar.showCustomSnackbar(
                              message: "User Created Successfully",
                              context: context,
                            );

                            // Navigate back
                            Navigator.of(context).pop();
                          } on FirebaseAuthException catch (error) {
                            log(error.code);
                            log("${error.message}");
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
                        fixedSize: const Size(
                            175, 45), // Width and height of the button
                        backgroundColor: Colors.white
                            .withOpacity(0.3), // Semi-transparent background
                        elevation: 1, // Remove shadow if desired
                      ),
                      child: Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                Text(
                  "Already have an account?",
                  style: GoogleFonts.leagueSpartan(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Log in",
                    style: GoogleFonts.leagueSpartan(
                      fontWeight: FontWeight.w600,
                      fontSize: 23,
                      color: const Color.fromRGBO(220, 220, 99, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom widget for text fields
class ProfileTextFieldForSignupScreen extends StatefulWidget {
  final String label;
  final String hintText;
  const ProfileTextFieldForSignupScreen(
      {super.key, required this.label, required this.hintText});

  @override
  State<ProfileTextFieldForSignupScreen> createState() =>
      _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextFieldForSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: GoogleFonts.poppins(
              color: const Color.fromRGBO(137, 108, 254, 1),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              filled: true,
              fillColor: Colors.transparent,
              hintStyle:
                  GoogleFonts.poppins(fontSize: 16, color: Colors.white60),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
