// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_buddy/controller/sessions.dart';
import 'package:flex_buddy/view/details_screen/height_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  int _currentValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.shade900,
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              
              /// How Old Are You? TEXT
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  textAlign: TextAlign.center,
                  "How Old Are You ?",
                  style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),

              /// How Old Are You? TEXT
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                child: Text(
                  textAlign: TextAlign.center,
                  "Let Us Know You Better!",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),

              const SizedBox(height: 45),

              /// SELECTED AGE
              Text(
                "$_currentValue",
                style: GoogleFonts.poppins(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),

              const SizedBox(height: 35),

              /// UPWARD ICON SVG
              SvgPicture.asset(
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                "assets/svg/upward_arrow.svg",
                height: 32,
                width: 46,
              ),

              const SizedBox(height: 35),

              // Number picker with full width and fixed height
              Container(
                width: double.infinity, // Full width
                height: 100, // Fixed height
                decoration: const BoxDecoration(
                  color: Color(0xFFB3A0FF), // Set background color to B3A0FF
                ),
                child: Stack(children: [
                  Center(
                    child: NumberPicker(
                      axis: Axis.horizontal,
                      minValue: 10,
                      maxValue: 100,
                      value: _currentValue,
                      onChanged: (value) =>
                          setState(() => _currentValue = value),
                      textStyle: GoogleFonts.poppins(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45, // Unselected number color
                      ),
                      selectedTextStyle: GoogleFonts.poppins(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Selected number color
                        height:
                            1.2, // Adjusted line height to center the text vertically
                      ),
                      itemCount:
                          5, // Show 5 items (2 on the left, 1 selected, 2 on the right)
                      itemWidth: MediaQuery.of(context).size.width /
                          5, // Divide the screen width for 5 items
                    ),
                  ),
                  Positioned(
                    left: 162,
                    child: Container(
                      height: 118,
                      width: 4,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    right: 162,
                    child: Container(
                      height: 118,
                      width: 4,
                      color: Colors.white,
                    ),
                  ),
                ]),
              ),

              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: Container(
                    width: 220,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.black,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF9796F0).withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      onPressed: () async {
                            try {
                              // Get the current user session data (assuming it has email stored)
                              await SessionData.getSessionData();

                              // Log email to confirm retrieval
                              log(SessionData.emailId);

                              // Reference to the Firestore document
                              String userEmail = SessionData.emailId;
                              var userDoc = FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(userEmail);

                              // Update the 'gender' field in the Firestore document
                              await userDoc.update({
                                'age': _currentValue,
                              });

                              log('age updated successfully!');

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const HeightScreen()),
                              );
                            } catch (e) {
                              log('Error updating gender: $e');
                            }
                          },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "Continue",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}