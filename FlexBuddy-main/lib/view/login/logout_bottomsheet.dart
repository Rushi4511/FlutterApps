import 'package:flex_buddy/controller/sessions.dart';
import 'package:flex_buddy/view/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

void openLogoutBottomsheet(BuildContext context){
  
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.black,
    builder: (BuildContext context) {
      return Container(
        height: 230,
        padding: const EdgeInsets.only(
          top: 35
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.white10,
            Colors.white10
          ]),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              textAlign: TextAlign.center,
              'Are you sure you want\n to logout ?',
              style: GoogleFonts.montserrat(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w500
              )
            ),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    minimumSize: const Size(160, 40),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 20, 
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async{
                    await SessionData.storeSessionData(emailId: "",isFirstTime: false,isLogin: false);
                    // Navigator.of(context).pushAndRemoveUntil(
                    //   MaterialPageRoute(builder: (context) => const LoginScreen(),), (route) => false);

                    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                      context,
                      screen: const LoginScreen(), // Replace with your LoginScreen widget
                      settings: const RouteSettings(name: '/login'),
                      withNavBar: false, // Set to false if you don't want the bottom nav bar
                      pageTransitionAnimation: PageTransitionAnimation.cupertino, // Optional animation
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    minimumSize: const Size(160, 40), // Adjusts button size
                  ),
                  child: Text(
                    'Yes, logout',
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 20, 
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      );
    }
  );
}
