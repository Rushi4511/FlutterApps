import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  List photos1 = [
    "assets/images/DeadInside.png",
    "assets/images/Alone2.png",
    "assets/images/heartless.png",
    "assets/images/DeadInside.png",
    "assets/images/Alone2.png",
  ];

  List photos2 = [
    "assets/images/weAreChaos.png",
    "assets/images/Smile.png",
    "assets/images/alone.png",
    "assets/images/weAreChaos.png",
    "assets/images/Smile.png",
  ];

  List title1 = [
    "Dead inside",
    "Alone",
    "Heartless",
    "Dead inside",
    "Alone",
  ];
  List title2 = [
    "We Are Chaos",
    "Smile",
    "Heartless",
    "We Are Chaos",
    "Smile",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 24, 24, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 405,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 20)],
                  ),
                  child: Image.asset(
                    "assets/images/alone.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 275,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "A.L.O.N.E",
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: 127,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 46, 0, 1),
                            borderRadius: BorderRadius.circular(19),
                          ),
                          child: Text("Get Started",
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 415,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: DotsIndicator(
                      dotsCount: 3,
                      position: 0,
                      decorator: DotsDecorator(
                        color: const Color.fromRGBO(159, 159, 159, 1),
                        activeColor: const Color.fromRGBO(255, 46, 0, 1),
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Discography",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: Color.fromRGBO(255, 46, 0, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )),
                      const Spacer(),
                      Text("See all",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: Color.fromRGBO(248, 162, 69, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      itemCount: 5,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 120,
                                height: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    photos1[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                title1[index],
                                style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                      color: Color.fromRGBO(203, 200, 200, 1)),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text("2020",
                                  style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                        color: Color.fromRGBO(132, 125, 125, 1),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  )),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Popular Singles",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: Color.fromRGBO(203, 200, 200, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )),
                      const Spacer(),
                      Text("See all",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: Color.fromRGBO(248, 162, 69, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 500,
                    child: ListView.builder(
                        itemCount: 5,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                Container(
                                  width: 75,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ClipRRect(
                                    child: Image.asset(
                                      photos2[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(title2[index],
                                        style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                              color: Color.fromRGBO(
                                                  203, 200, 200, 1),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    const SizedBox(
                                      height: 1,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text("2023",
                                                style: GoogleFonts.inter(
                                                  textStyle: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          132, 125, 125, 1),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )),
                                            DotsIndicator(
                                              dotsCount: 1,
                                              decorator: DotsDecorator(
                                                activeColor: Color.fromRGBO(
                                                    132, 125, 125, 1),
                                              ),
                                            ),
                                            Text("Easy living",
                                                style: GoogleFonts.inter(
                                                  textStyle: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          132, 125, 125, 1),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(19, 19, 19, 1),
        selectedItemColor: Color.fromRGBO(230, 154, 21, 1),
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: "Like",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
