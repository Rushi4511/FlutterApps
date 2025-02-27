import 'package:flex_buddy/controller/sessions.dart';
import 'package:flex_buddy/view/login/login_screen.dart';
import 'package:flex_buddy/view/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


class OnboardingScreens extends StatelessWidget {
  final Color kDarkBlueColor = const Color(0xFFE2F163);

  const OnboardingScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'Login',
      finishButtonTextStyle: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
      onFinish: () async{
        await SessionData.storeSessionData(isLogin: false, emailId: "", isFirstTime: false);
        
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false
        );
      },
      finishButtonStyle: const FinishButtonStyle(
        backgroundColor: Colors.black,
        shape: StadiumBorder()
      ),
      skipTextButton: Text(
        'Skip',
        style: GoogleFonts.poppins(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        'Register',
        style: GoogleFonts.poppins(
          fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white
        ),
      ),
      trailingFunction: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const SignupScreen(),
          ),
          (route) => false
        );
      },
      controllerColor: Colors.white,
      totalPage: 3,
      headerBackgroundColor: Colors.black,
      pageBackgroundColor: Colors.black,
      background: [
        Image.asset(
          'assets/images/1.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.contain,
        ),
        Image.asset(
          'assets/images/2.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.contain,
        ),
        Image.asset(
          'assets/images/4.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.contain,
        ),
      ],
      speed: 1,
      pageBodies: [
        Column(
          children: <Widget>[
            const Spacer(),
            Column(
            children: [
              Text(
                "Welcome to",
                style: GoogleFonts.leagueSpartan(
                  fontWeight: FontWeight.bold,
                  color: kDarkBlueColor,
                  fontSize: 30
                ),
              ),
              const SizedBox(height: 30,),
        
              Stack(
                children: [
                  SvgPicture.asset(
                    "assets/svg/logo.svg",
                    width: 220,
                    height: 110,
                  ),
                  Positioned(
                    right: 25,
                    top: 5,
                    child: Image.asset(
                      'assets/images/lift.png',
                      height: 100,
                      width: 100,
                    ),
                  )
                ]
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Flex",
                    style: GoogleFonts.poppins(
                    fontStyle: FontStyle.italic,
                    color: const Color.fromRGBO(226, 241, 99, 1),
                      fontWeight: FontWeight.w800,
                      fontSize: 42
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Buddy",
                    style: GoogleFonts.poppins(
                      fontStyle: FontStyle.italic,
                      color: const Color.fromRGBO(226, 241, 99, 1),
                      fontSize: 44
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer()
          ],
        ),
        Column(
          children: <Widget>[
            const Spacer(),
            Column(
              children: [
                Container(
                  height: 170,
                  color: const Color.fromRGBO(179, 160, 255, 1),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                      right: 40
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 16,),
                        SvgPicture.asset(
                          "assets/svg/onboarding2.svg",
                          height: 40,
                          width: 45,
                        ),
                        const SizedBox(height: 20,),
                        Text(
                          "Start your journey towards a more active lifestyle",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(height: 10,),
                      ], 
                    ),
                  )
                )
              ]
            ),
            const Spacer(),
          ],
        ),
        Column(
          children: <Widget>[
            const Spacer(),
            Container(
                height: 170,
                width: 420,
                color: const Color.fromRGBO(179, 160, 255, 1),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 16,),
                      SvgPicture.asset(
                        "assets/svg/onboarding4.svg",
                        height: 42,
                        width: 65,
                      ),

                      const SizedBox(height: 20,),
                      
                      Text(
                        "A community for you, challenge yourself",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ], 
                  ),
                ),
              ),
              const Spacer(),
        
          ],
        ),
      ],
    );
  }
}