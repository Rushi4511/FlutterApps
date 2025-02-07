import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: 415,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(245, 146, 69, 1)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(children: [
                    Image.asset(
                      "assets/images/main_screen_back.png",
                      width: 183,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 40,
                      left: 35,
                      child: Image.asset(
                        "assets/images/main_screen_above.png",
                        height: 104,
                        fit: BoxFit.cover,
                      ),
                    )
                  ]),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Email",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(0, 0, 0, 1)),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color:
                        Color.fromRGBO(245, 146, 69, 1), // Default border color
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.blue, // Border color when clicked
                    width: 2,
                  ),
                ),
                hintText: "PetGuardian@gmail.com",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(194, 195, 204, 1),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Password",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(0, 0, 0, 1)),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(
                  Icons.remove_red_eye,
                  color: Color.fromRGBO(245, 146, 69, 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color:
                        Color.fromRGBO(245, 146, 69, 1), // Default border color
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.blue, // Border color when clicked
                    width: 2,
                  ),
                ),
                hintText: "Password",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(194, 195, 204, 1),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Forgot Password ? Click Here",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 1)),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 375,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(245, 146, 69, 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "LOGIN",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Divider(
                  color: Colors.orange,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 40,
                  width: 375,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(245, 146, 69, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "CONTINUE WITH EMAIL",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  width: 375,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(245, 146, 69, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "CONTINUE WITH FACEBOOK",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "By continue you agree to our \nTerms & Privacy Policy",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 1)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
