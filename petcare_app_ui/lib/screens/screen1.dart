import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_app_ui/screens/screen2.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(245, 146, 69, 1),
        body: Stack(
          children: [
            Positioned(
              top: 300,
              left: 90,
              child: GestureDetector(
                onDoubleTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Screen2();
                  }));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/onBoard_logo.png",
                      height: 193,
                      width: 183,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "PetGuardian",
                      style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Your Pets' Lifelong Protector",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(255, 255, 255, 1)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
