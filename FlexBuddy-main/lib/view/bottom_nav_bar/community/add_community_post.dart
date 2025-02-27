// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_buddy/colors.dart';
import 'package:flex_buddy/controller/sessions.dart';
import 'package:flex_buddy/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class AddCommunityPost extends StatefulWidget {
  const AddCommunityPost({super.key});

  @override
  State<AddCommunityPost> createState() => _AddCommunityPostState();
}

class _AddCommunityPostState extends State<AddCommunityPost> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  double containerHeight = 460;
  late String email;
  String? name;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Character count limits
  final int titleMaxLength = 100;
  final int descriptionMaxLength = 2000;

  Future<void> collectData() async {
    await SessionData.getSessionData();
    email = SessionData.emailId;
    log("-------------On Add Post  Screen $email");
    await getUserName(email);
  }

  Future<void> getUserName(String email) async {
    try {
      final firestore = FirebaseFirestore.instance;
      DocumentSnapshot docSnapshot =
          await firestore.collection('Users').doc(email).get();

      if (docSnapshot.exists) {
        setState(() {
          name = docSnapshot.get('name');
          log(name!);
        });
      } else {
        print('Document does not exist');
        setState(() {
          name = "Anonymous";
        });
      }
    } catch (e) {
      print('Error fetching name: $e');
      setState(() {
        name = "Error";
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      if (mounted) {
        CustomSnackbar.showCustomSnackbar(
          message: "Failed to pick image",
          context: context,
        );
      }
    }
  }


  @override
  void initState() {
    super.initState();
    collectData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            if (titleController.text.isNotEmpty ||
                                descriptionController.text.isNotEmpty ||
                                _image != null) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: const Color(0xFF1E1E1E),
                                  title: Text(
                                    "Discard Post?",
                                    style:
                                        GoogleFonts.poppins(color: Colors.white),
                                  ),
                                  content: Text(
                                    "Your post will be discarded if you leave this page.",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white70),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        "Cancel",
                                        style: GoogleFonts.poppins(
                                          color: const Color.fromRGBO(
                                              137, 108, 254, 1),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context); // Close dialog
                                        Navigator.pop(context); // Go back
                                      },
                                      child: Text(
                                        "Discard",
                                        style: GoogleFonts.poppins(
                                            color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: MyColors.yellow,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Add Community Post",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: MyColors.yellow,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: Colors.white12,
                        border: Border.all(
                          color: const Color.fromRGBO(137, 108, 254, 0.3),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User Info Section
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white54,
                                    width: 1,
                                  ),
                                ),
                                child: const CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Color(0xFF2E2E2E),
                                  child: Icon(
                                    Icons.account_circle,
                                    color: Colors.white70,
                                    size: 45,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                name ?? "Loading...",
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
          
                          // Title Input
                          Text(
                            "Title",
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: titleController,
                            maxLines: 1,
                            maxLength: titleMaxLength,
                            style: GoogleFonts.montserrat(color: Colors.white),
                            onChanged: (value) => setState(() {}),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFF2E2E2E),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.yellow.shade300,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white24,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'Write an engaging title...',
                              hintStyle:
                                  GoogleFonts.montserrat(color: Colors.white54),
                              counterStyle:
                                  GoogleFonts.montserrat(color: Colors.white54),
                            ),
                          ),
                          const SizedBox(height: 15),
          
                          // Description Input
                          Text(
                            "Description",
                            style: GoogleFonts.montserrat(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: descriptionController,
                            maxLines: 8,
                            maxLength: descriptionMaxLength,
                            style: GoogleFonts.montserrat(color: Colors.white),
                            onChanged: (value) => setState(() {}),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFF2E2E2E),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.yellow.shade300,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white24,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'Share your thoughts...',
                              hintStyle:
                                  GoogleFonts.montserrat(color: Colors.white54),
                              counterStyle:
                                  GoogleFonts.montserrat(color: Colors.white54),
                            ),
                          ),
                          const SizedBox(height: 15),
          
                          // Attachment Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton.icon(
                                onPressed: _pickImage,
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  backgroundColor: Colors.white.withOpacity(0.1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: Icon(
                                  Icons.attach_file,
                                  color: MyColors.yellow,
                                  size: 20,
                                ),
                                label: Text(
                                  'Add Image',
                                  style: GoogleFonts.montserrat(
                                    color: MyColors.yellow,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              if (_image != null)
                                TextButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      _image = null;
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    backgroundColor: Colors.red.withOpacity(0.1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  label: Text(
                                    'Remove Image',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                            ],
                          ),
          
                          // Image Preview
                          if (_image != null) ...[
                            const SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white24,
                                  width: 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: isLoading ? 190 : 190,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                                  if (titleController.text.trim().isNotEmpty &&
                                      descriptionController.text
                                          .trim()
                                          .isNotEmpty) {
                                    setState(() => isLoading = true);
                                    try {
                                      final now = DateTime.now();
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy').format(now);
                                      String formattedTime =
                                          DateFormat('HH:mm').format(now);
          
                                      // Upload image if selected
                                      String? imageUrl;
                                      if (_image != null) {
                                        try {
                                          final String fileName =
                                              '${DateTime.now().millisecondsSinceEpoch}.jpg';
                                          final Reference storageRef =
                                              FirebaseStorage.instance
                                                  .ref()
                                                  .child('community_posts')
                                                  .child(fileName);
          
                                          await storageRef.putFile(_image!);
                                          imageUrl =
                                              await storageRef.getDownloadURL();
                                        } catch (e) {
                                          log("Error uploading image: $e");
                                          if (mounted) {
                                            CustomSnackbar.showCustomSnackbar(
                                              message: "Failed to upload image",
                                              context: context,
                                            );
                                          }
                                        }
                                      }
          
                                      Map<String, dynamic> postData = {
                                        "name": name,
                                        "title": titleController.text.trim(),
                                        "description":
                                            descriptionController.text.trim(),
                                        'date': formattedDate,
                                        'time': formattedTime,
                                        "likes": 0,
                                        "imageUrl": imageUrl,
                                      };
          
                                      // Save to all community posts
                                      await FirebaseFirestore.instance
                                          .collection("All Community Posts")
                                          .doc(
                                              '$name $formattedDate $formattedTime')
                                          .set(postData);
          
                                      // Save to user's posts
                                      await FirebaseFirestore.instance
                                          .collection("Users")
                                          .doc(email)
                                          .collection("My Community Posts")
                                          .doc(
                                              '$name $formattedDate $formattedTime')
                                          .set(postData);
          
                                      if (mounted) {
                                        CustomSnackbar.showCustomSnackbar(
                                          message: "Post Added Successfully!",
                                          context: context,
                                        );
                                        Navigator.pop(context, true);
                                      }
                                    } catch (e) {
                                      log("Error: $e");
                                      if (mounted) {
                                        CustomSnackbar.showCustomSnackbar(
                                          message: "Failed to create post",
                                          context: context,
                                        );
                                      }
                                    } finally {
                                      if (mounted) {
                                        setState(() => isLoading = false);
                                      }
                                    }
                                  } else {
                                    CustomSnackbar.showCustomSnackbar(
                                      message: "Please fill out all fields",
                                      context: context,
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(137, 108, 254, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 5,
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text(
                                  "POST",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ]))),
        ));
  }
}
