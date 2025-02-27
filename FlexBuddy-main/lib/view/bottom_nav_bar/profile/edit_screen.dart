// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_buddy/controller/sessions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_avatar/random_avatar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late String email;
  String? name;
  String? avatarSeed;
  String? weight;
  String? age;
  String? height;
  String? phone;
  String? dob;
  bool isLoading = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController heightController= TextEditingController();

  Future<void> fetchUserData() async {
    try {
      await SessionData.getSessionData();
      email = SessionData.emailId;

      final firestore = FirebaseFirestore.instance;
      DocumentSnapshot docSnapshot = await firestore.collection('Users').doc(email).get();

      if (docSnapshot.exists) {
        setState(() {
          name = docSnapshot.get('name').toString();
          avatarSeed = docSnapshot.get('avatar').toString();
          weight = docSnapshot.get('weight').toString();
          age = docSnapshot.get('age').toString();
          height = docSnapshot.get('height').toString();
          phone = docSnapshot.get('mobileNo').toString();
          
          emailController.text = email;
          nameController.text = name!;
          heightController.text = height!;
          weightController.text = weight!;
          phoneController.text = phone!;
          isLoading = false;
        });
      } else {
        log('Document does not exist');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      log('Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateProfile() async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('Users').doc(email).update({
        'name': nameController.text,
        'mobileNo': phoneController.text,
        'weight': double.parse(weightController.text),
        'height': double.parse(heightController.text),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profile Updated Successfully!',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: const Color(0xFF896CFE),
        ),
      );

      Navigator.of(context).pop();
    } catch (e) {
      log('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to update profile',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    // _nameController.dispose();
    // _emailController.dispose();
    // _phoneController.dispose();
    // _weightController.dispose();
    // _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF896CFE)))
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Color(0xFF896CFE),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Edit Profile",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: const Color(0xFF896CFE),
                              
                            ),
                          ),
                        ],
                      ),
                      // Profile Avatar
                      const SizedBox(height: 30),
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF896CFE),
                                  const Color(0xFF896CFE).withOpacity(0.5),
                                ],
                              ),
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: RandomAvatar(
                                avatarSeed!,
                                height: 150,
                                width: 150,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFF896CFE),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Stats Card
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF896CFE).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF896CFE).withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStat('Weight', '$weight kg'),
                            _buildDivider(),
                            _buildStat('Height', '$height cm'),
                            _buildDivider(),
                            _buildStat('Age', age ?? 'N/A'),
                          ],
                        ),
                      ),

                      // Form Fields
                      const SizedBox(height: 30),
                      _buildTextField('Full Name',nameController),
                      _buildTextField('Email', emailController ,isEnabled: false),
                      _buildTextField('Phone',phoneController),
                      _buildTextField('Weight',weightController),
                      _buildTextField('Height', heightController),

                      // Update Button
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: updateProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF896CFE),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          'Update Profile',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: const Color(0xFF896CFE).withOpacity(0.3),
    );
  }

  Widget _buildTextField(
    String label, 
    TextEditingController controller, 
    {bool isEnabled = true}
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        enabled: isEnabled,
        style: GoogleFonts.poppins(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: 16,
          ),
          suffixIcon: isEnabled
              ? const Icon(
                  Icons.edit,
                  color: Colors.white70,
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: const Color(0xFF896CFE).withOpacity(0.3),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: const Color(0xFF896CFE).withOpacity(0.3),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFF896CFE),
            ),
          ),
          filled: true,
          fillColor: const Color(0xFF896CFE).withOpacity(0.1),
        ),
      ),
    );
  }
}