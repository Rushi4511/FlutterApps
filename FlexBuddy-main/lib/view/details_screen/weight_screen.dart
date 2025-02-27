import 'dart:developer';

import 'package:flex_buddy/view/details_screen/avatar_selection.dart';
import 'package:flex_buddy/controller/sessions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WeightScreen extends StatefulWidget {
  final bool fromEdit;
  
  const WeightScreen({super.key,required this.fromEdit});

  @override
  State createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> with SingleTickerProviderStateMixin {
  double selectedWeight = 50.0;
  double? heaviestWeight;
  double? lightestWeight;
  late RulerPickerController _controller;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isSaving = false;

  late String email;

  // Firebase instances
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> collectData() async {
    await SessionData.getSessionData();
    email = SessionData.emailId;
  }
  
  @override
  void initState() {
    super.initState();
    _controller = RulerPickerController(value: selectedWeight);
    
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
    _loadExistingWeight();
  });
  }

  Future<void> _loadExistingWeight() async {
    try {
      await collectData();
      
      final docSnapshot = await _firestore.collection('Users').doc(email).get();
      
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        
        if (data != null) {
          if (data.containsKey('weight')) {
            setState(() {
              selectedWeight = data['weight'].toDouble();
              _controller.value = selectedWeight;
            });
          }
          
          if (data.containsKey('heaviestWeight')) {
            heaviestWeight = data['heaviestWeight'].toDouble();
          }
          if (data.containsKey('lightestWeight')) {
            lightestWeight = data['lightestWeight'].toDouble();
          }
          
        }
      }
    // ignore: empty_catches
    } catch (e) {
      
    }
  }

  // Save weight to Firestore
  Future<void> _saveWeightToFirestore() async {
    setState(() => _isSaving = true);
    
    try {
      final trimmedWeight = double.parse(selectedWeight.toStringAsFixed(1));
      
      // Prepare the update data
      Map<String, dynamic> updateData = {
        'weight': trimmedWeight,
        'updatedAt': FieldValue.serverTimestamp(),
        'weightArray': FieldValue.arrayUnion([trimmedWeight])
      };

      // Update heaviest weight if necessary
      if (heaviestWeight == null || trimmedWeight > heaviestWeight!) {
        updateData['heaviestWeight'] = trimmedWeight;
        log("New heaviest weight: $trimmedWeight");
      }

      // Update lightest weight if necessary
      if (lightestWeight == null || trimmedWeight < lightestWeight!) {
        updateData['lightestWeight'] = trimmedWeight;
        log("New lightest weight: $trimmedWeight");
      }

      // Save to Firestore
      await _firestore.collection('Users').doc(email).set(
        updateData,
        SetOptions(merge: true)
      );

      log("Weight data saved successfully");

      // Navigate to next screen
      
      if (mounted) {
        if (widget.fromEdit) {
          Navigator.of(context).pop();
        }else{
          Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AvatarSelectionScreen(),)
        );
        }
      }
    } catch (e) {
      log("Error saving weight data: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving weight: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  
                  const SizedBox(height: 30),
                  
                  // Title and Weight Display
                  Center(
                    child: Container(
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
                            "What is Your Weight?",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                selectedWeight.toStringAsFixed(1),
                                style: GoogleFonts.poppins(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12, left: 8),
                                child: Text(
                                  'kg',
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
                  ),

                  const SizedBox(height: 100),
                  
                  // Ruler Container
                  Container(
                    height: 150,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: RulerPicker(
                      controller: _controller,
                      onValueChanged: (value) {
                        setState(() {
                          selectedWeight = value.toDouble();
                        });
                      },
                      width: MediaQuery.of(context).size.width - 40,
                      height: 80,
                      onBuildRulerScaleText: _buildRulerScaleText,
                      ranges: const [
                        RulerRange(
                          begin: 20,
                          end: 200,
                          scale: 0.1,
                        ),
                      ],
                      rulerMarginTop: 15,
                      scaleLineStyleList: [
                        ScaleLineStyle(
                          scale: 0,
                          color: Colors.white.withOpacity(0.8),
                          width: 2,
                          height: 40,
                        ),
                        const ScaleLineStyle(
                          scale: 5,
                          color: Colors.white,
                          width: 2,
                          height: 30,
                        ),
                        ScaleLineStyle(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                          height: 20,
                        ),
                      ],
                      rulerScaleTextStyle: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                      marker: Container(
                        width: 2,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(226, 241, 99, 1).withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      rulerBackgroundColor: Colors.transparent,
                    ),
                  ),

                  const Spacer(),

                  // Continue Button
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
                          onPressed: _isSaving ? null : _saveWeightToFirestore,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: _isSaving
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
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