import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:home_rental_app_ui/screens/screen2.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            "assets/images/screen1_OnBoard.png",
            height: 650,
            width: 420,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Lets find your Paradise",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Find your perfect dream space \nwith just a few clicks",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(101, 101, 101, 1),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Screen2();
                  }));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  width: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromRGBO(32, 169, 247, 1)),
                  child: Text(
                    "Get Started",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
