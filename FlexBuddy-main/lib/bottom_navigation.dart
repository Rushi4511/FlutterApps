import 'package:flex_buddy/colors.dart';
import 'package:flex_buddy/view/bottom_nav_bar/profile/profile_screen.dart';
import 'package:flex_buddy/view/bottom_nav_bar/community/community_screen.dart';
import 'package:flex_buddy/view/bottom_nav_bar/reports.dart';
import 'package:flex_buddy/view/bottom_nav_bar/workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.fitness_center, size: 25),
          title: "Exercise",
          activeColorPrimary: MyColors.yellow,
          inactiveColorPrimary: Colors.white,
          textStyle:
              GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.groups_2_sharp,
            size: 25,
          ),
          title: "Forum",
          activeColorPrimary: MyColors.yellow,
          inactiveColorPrimary: Colors.white,
          textStyle:
              GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.library_books_outlined, size: 28),
          title: "Reports",
          activeColorPrimary: MyColors.yellow,
          inactiveColorPrimary: Colors.white,
          textStyle:
              GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person, size: 28),
          title: "Profile",
          activeColorPrimary: MyColors.yellow,
          inactiveColorPrimary: Colors.white,
          textStyle:GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500,)),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      const WorkoutScreen(),
      const CommunityScreen(),
      const ReportScreen(),
      const ProfileScreen(),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: false,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardAppears: true,
      navBarHeight: kBottomNavigationBarHeight +20,
      backgroundColor: Colors.black26,
      navBarStyle: NavBarStyle.style1,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(16),
        colorBehindNavBar: Colors.black26,
      ),
    );
  }
}


/*
  static List<Color> _getGradientColors(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return [
          const Color(0xFF00B09B),
          const Color(0xFF96C93D),
        ];
      case SnackbarType.error:
        return [
          const Color(0xFFFF416C),
          const Color(0xFFFF4B2B),
        ];
      case SnackbarType.info:
        return [
          const Color(0xFF896CFE),
          const Color(0xFF6C63FF),
        ];
    }
  }

  */
