// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_buddy/controller/sessions.dart';
import 'package:flex_buddy/view/details_screen/focus_body_parts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen>
    with SingleTickerProviderStateMixin {
  String? selectedGender;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  const SizedBox(height: 40),

                  // Title with Glowing Effect
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: Text(
                      "What's Your Gender?",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 45),

                  // Gender Options
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Male Option
                      _buildGenderOption(
                        gender: "male",
                        icon: "assets/svg/male.svg",
                        label: "Male",
                        gradientColors: const [
                          Color(0xFF9796F0),
                          Color(0xFFFBC7D4)
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      // Female Option
                      _buildGenderOption(
                        gender: "female",
                        icon: "assets/svg/female.svg",
                        label: "Female",
                        gradientColors: const [
                          Color(0xFFFFB199),
                          Color(0xFFFF0844)
                        ],
                      ),
                    ],
                  ),

                  const Spacer(),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 60),
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
                            if (selectedGender != null) {
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
                                  'gender':
                                      selectedGender, // selectedGender holds the value of the gender
                                });

                                log('Gender updated successfully!');
                                
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => const FocusBodyParts(),)
                                );
                                
                              } catch (e) {
                                log('Error updating gender: $e');
                              }
                            } else {
                              log('Gender not selected');
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
        ),
      ),
    );
  }

  Widget _buildGenderOption({
    required String gender,
    required String icon,
    required String label,
    required List<Color> gradientColors,
  }) {
    final isSelected = selectedGender == gender;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
          log(selectedGender!);
        });
      },
      child: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: isSelected
                    ? gradientColors
                    : [Colors.grey.shade800, Colors.grey.shade700],
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: gradientColors[0].withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
              border: Border.all(
                color:
                    isSelected ? Colors.white : Colors.white.withOpacity(0.3),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                icon,
                height: 80,
                width: 80,
                colorFilter: ColorFilter.mode(
                  isSelected ? Colors.white : Colors.white.withOpacity(0.7),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
