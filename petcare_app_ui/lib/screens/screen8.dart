import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Screen8 extends StatefulWidget {
  const Screen8({super.key});

  @override
  State<Screen8> createState() => _Screen8State();
}

class _Screen8State extends State<Screen8> {
  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive layout
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController searchController1 = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          // Background Image (Optional)
          Column(  
            
          )
          // Discount Container (Positioned within the Stack)
          Positioned(
            top: 0,
            child: Container(
              height: 200,
              width: screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                color: Color.fromRGBO(245, 146, 69, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 15,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "60% OFF",
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "On hair & spa treatment",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Image.asset(
                      "assets/images/s7_dog1.png",
                      width: 175,
                      height: 175,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 16,
            child: TextField(
              controller: searchController1,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                suffixIcon: Icon(
                  Icons.search,
                  color: Color.fromRGBO(245, 146, 69, 1),
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(245, 146, 69, 1),
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                hintText: "Search",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
