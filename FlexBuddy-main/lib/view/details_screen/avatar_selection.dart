import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_buddy/bottom_navigation.dart';
import 'package:flex_buddy/colors.dart';
import 'package:flex_buddy/controller/sessions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_avatar/random_avatar.dart';

class AvatarSelectionScreen extends StatefulWidget {
  const AvatarSelectionScreen({super.key});

  @override
  State<AvatarSelectionScreen> createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  String? selectedAvatar;
  List<String> avatarSeeds = [];
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _loadMoreAvatars();
  }

  void _loadMoreAvatars() {
    setState(() {
      isLoading = true;
      avatarSeeds.addAll(
        List.generate(
          30,
          (index) =>
              DateTime.now().millisecondsSinceEpoch.toString() +
              (avatarSeeds.length + index).toString(),
        ),
      );
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: MyColors.yellow,
                    )),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "Choose Avatar",
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600, color: MyColors.yellow),
                ),
              ],
            ),
            const SizedBox(height: 30),
            if (selectedAvatar != null) ...[
              Text(
                'Selected Avatar',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: RandomAvatar(
                  selectedAvatar!,
                  height: 120,
                  width: 120,
                ),
              ),
            ],
            const SizedBox(height: 20),
            Text(
              'Available Avatars',
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: avatarSeeds.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAvatar = avatarSeeds[index];
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selectedAvatar == avatarSeeds[index]
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                            child: RandomAvatar(
                              avatarSeeds[index],
                              height: 80,
                              width: 80,
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton.icon(
                        onPressed: isLoading ? null : _loadMoreAvatars,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.yellow,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 2,
                          disabledBackgroundColor:
                              MyColors.yellow.withOpacity(0.4),
                        ),
                        icon: isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.black,
                                  backgroundColor:
                                      MyColors.yellow.withOpacity(0.3),
                                ),
                              )
                            : const Icon(Icons.refresh, color: Colors.black),
                        label: Text(
                          isLoading ? 'Loading...' : 'Load More',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: selectedAvatar == null
                    ? null
                    : () async {
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
                          await userDoc.update(
                              {'avatar': selectedAvatar, 'isInfoFilled': true});
        
                          log('info Avatar updated successfully!');
        
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CustomBottomNavigationBar(),
                              ),
                              (route) => false);
                        } catch (e) {
                          log('Error updating gender: $e');
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.yellow,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                  disabledBackgroundColor: MyColors.yellow
                ),
                child: Text(
                  'Save Avatar',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
