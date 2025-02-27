// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_buddy/controller/sessions.dart';
import 'package:flex_buddy/view/details_screen/weight_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen>
    with SingleTickerProviderStateMixin {
  double selectedHeight = 155.0;
  late RulerPickerController _controller;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = RulerPickerController(value: selectedHeight);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _buildRulerScaleText(int index, num value) {
    return value.toStringAsFixed(1);
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
                  const SizedBox(height: 40),
                  // Height Display Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Your Height',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              selectedHeight.toStringAsFixed(1),
                              style: GoogleFonts.poppins(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 12, left: 8),
                              child: Text(
                                'cm',
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Ruler Section
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: RulerPicker(
                        controller: _controller,
                        onValueChanged: (value) {
                          setState(() {
                            selectedHeight = double.parse(value.toStringAsFixed(1));
                          });
                        },
                        width: MediaQuery.of(context).size.width - 40,
                        height: 130,
                        onBuildRulerScaleText: _buildRulerScaleText,
                        ranges: const [
                          RulerRange(
                            begin: 20,
                            end: 200,
                            scale: 0.1,
                          ),
                        ],
                        rulerMarginTop: 1,
                        scaleLineStyleList: [
                          ScaleLineStyle(
                            scale: 0,
                            color: Colors.white.withOpacity(0.8),
                            width: 2,
                            height: 35,
                          ),
                          ScaleLineStyle(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                            height: 15,
                          ),
                        ],
                        rulerScaleTextStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                        marker: Container(
                          width: 2,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromRGBO(226, 241, 99, 1)
                                    .withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        rulerBackgroundColor: Colors.transparent,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Continue Button
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
                                'height': selectedHeight
                              });

                              log('height updated successfully!');

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const WeightScreen(fromEdit: false,)),
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
        ),
      ),
    );
  }
}
