import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:music_app_task_01/screens/screen2.dart";

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/musicScreen1.png",
                  width: 497,
                  height: 648,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                )
              ],
            ),
          ),
          Positioned(
            top: 400,
            left: 50,
            child: Text("Dancing between \nThe shadows \nOf rhythm ",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w600),
                )),
          ),
          Positioned(
            top: 575,
            left: 75,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Screen2();
                }));
              },
              child: Container(
                height: 50,
                width: 270,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 46, 0, 1),
                    borderRadius: BorderRadius.circular(19)),
                child: Text("Get Started",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ),
          ),
          Positioned(
            top: 650,
            left: 75,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
                width: 270,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(255, 46, 0, 1)),
                    borderRadius: BorderRadius.circular(19)),
                child: Text("Continue with Email",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: Color.fromRGBO(255, 46, 0, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ),
          ),
          Positioned(
            top: 750,
            left: 90,
            child: Text(
                "by continuing you agree to terms \nservices and  Privacy policy",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    color: Color.fromRGBO(203, 200, 200, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
