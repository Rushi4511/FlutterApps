import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_buddy/controller/sessions.dart';
import 'package:flex_buddy/view/bottom_nav_bar/profile/edit_screen.dart';
import 'package:flex_buddy/view/bottom_nav_bar/profile/privacy_policy.dart';
import 'package:flex_buddy/view/login/logout_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:random_avatar/random_avatar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  late String email;
  String? name;
  bool isLoading = true;
  String? avatarSeed;
  String? height;
  String? age;
  String? weight;

  Future<void> getUserName(String email) async {
    try {
      final firestore = FirebaseFirestore.instance;
      DocumentSnapshot docSnapshot = await firestore.collection('Users').doc(email).get();

      if (docSnapshot.exists) {
        setState(() {
          name = docSnapshot.get('name');
          avatarSeed = docSnapshot.get('avatar');
          weight = docSnapshot.get('weight').toString();
          age = docSnapshot.get('age').toString();
          height = docSnapshot.get('height').toString();
          log(name!);
          log(avatarSeed!);
          isLoading = false; // Data loaded
          log(name!);
        });
      } else {
        log('Document does not exist');
        setState(() {
          name = "Guest"; // Fallback name
          isLoading = false;
        });
      }
    } catch (e) {
      log('Error fetching name: $e');
      setState(() {
        name = "Error"; // Error fallback
        isLoading = false;
      });
    }
  }

  Future<void> collectData() async {
    await SessionData.getSessionData();
    email = SessionData.emailId;
    log("-------------On Screen $email");
    log(DateTime.now().millisecondsSinceEpoch.toString());
    await getUserName(email);
  }

  @override
  void initState() {
    super.initState();
    collectData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        
        onRefresh: collectData,
        color: const Color(0xFF896CFE),
        child: isLoading
            ? const Center(child: CircularProgressIndicator(color: Color(0xFF896CFE)))
            : Container(
                decoration: const BoxDecoration(
                  color: Colors.black
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildHeader(),
                        _buildProfileInfo(),
                        _buildStatsCard(),
                        _buildMenuItems(),
                        const SizedBox(height: 50,),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'My Profile',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
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
                height: 160,
                width: 160,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name!,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            const Color(0xFF896CFE).withOpacity(0.2),
            const Color(0xFF896CFE).withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF896CFE).withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('$weight Kg', 'Weight'),
          _buildDivider(),
          _buildStatItem( age!, 'Years Old'),
          _buildDivider(),
          _buildStatItem('$height CM', 'Height'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
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

  Widget _buildMenuItems() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.person,
            label: 'Edit Profile',
            onTap: () async{
              await PersistentNavBarNavigator.pushNewScreen(context, screen: const EditProfileScreen(),withNavBar: false);
              setState(() {
                
              });
            },
          ),
          _buildMenuItem(
            icon: Icons.privacy_tip,
            label: 'Privacy Policy',
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(context, screen: const PrivacyPolicy(),withNavBar: false);
            },
          ),
          
          _buildMenuItem(
            icon: Icons.logout,
            label: 'Logout',
            onTap: () {
              openLogoutBottomsheet(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF896CFE).withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF896CFE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF896CFE),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}