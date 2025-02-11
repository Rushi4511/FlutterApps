import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Screen7 extends StatefulWidget {
  const Screen7({super.key});

  @override
  State<Screen7> createState() => _Screen7State();
}

class _Screen7State extends State<Screen7> {
  TextEditingController searchController1 = TextEditingController();
  List<Map<String, String>> gromming = [
    {"name": "Bath & Drying", "image": "assets/images/bathing.png"},
    {"name": "Hair Triming", "image": "assets/images/hair_trimming.png"},
    {"name": "Nail Trimming", "image": "assets/images/nail_trimming.png"},
    {"name": "Ear Cleaning", "image": "assets/images/ear_cleaning.png"},
    {"name": "Brushing Teeths", "image": "assets/images/brushed.png"},
    {"name": "Fleas Injection", "image": "assets/images/fleas_injection.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          size: 20,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 2,
            width: 2,
            decoration: BoxDecoration(
                color: Color.fromRGBO(245, 146, 69, 1),
                borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              alignment: Alignment.center,
              padding: EdgeInsets.all(15),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              iconSize: 20,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Grooming",
          style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(31, 32, 41, 1)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                children: [
                  Container(
                    height: 125,
                    width: 415,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
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
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: searchController1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 10.0),
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
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Text(
                        "Our Services",
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "See All",
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 190,
                        width: 175,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color.fromRGBO(255, 255, 255, 1),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(22, 34, 51, 0.08),
                                  spreadRadius: 0,
                                  blurStyle: BlurStyle.solid,
                                  blurRadius: 16,
                                  offset: Offset(5, 5))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              gromming[0]['image']!,
                              width: 150,
                              height: 150,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              gromming[0]['name']!,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(245, 146, 69, 1)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Container(
                        height: 190,
                        width: 175,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color.fromRGBO(255, 255, 255, 1),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(22, 34, 51, 0.08),
                                  spreadRadius: 0,
                                  blurStyle: BlurStyle.solid,
                                  blurRadius: 16,
                                  offset: Offset(5, 5))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              gromming[1]['image']!,
                              width: 150,
                              height: 150,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              gromming[1]['name']!,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(245, 146, 69, 1)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 190,
                        width: 175,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color.fromRGBO(255, 255, 255, 1),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(22, 34, 51, 0.08),
                                  spreadRadius: 0,
                                  blurStyle: BlurStyle.solid,
                                  blurRadius: 16,
                                  offset: Offset(5, 5))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              gromming[2]['image']!,
                              width: 150,
                              height: 150,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              gromming[2]['name']!,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(245, 146, 69, 1)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Container(
                        height: 190,
                        width: 175,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color.fromRGBO(255, 255, 255, 1),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(22, 34, 51, 0.08),
                                  spreadRadius: 0,
                                  blurStyle: BlurStyle.solid,
                                  blurRadius: 16,
                                  offset: Offset(5, 5))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              gromming[3]['image']!,
                              width: 150,
                              height: 150,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              gromming[3]['name']!,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(245, 146, 69, 1)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 190,
                        width: 175,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color.fromRGBO(255, 255, 255, 1),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(22, 34, 51, 0.08),
                                  spreadRadius: 0,
                                  blurStyle: BlurStyle.solid,
                                  blurRadius: 16,
                                  offset: Offset(5, 5))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              gromming[4]['image']!,
                              width: 150,
                              height: 150,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              gromming[4]['name']!,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(245, 146, 69, 1)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Container(
                        height: 190,
                        width: 175,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color.fromRGBO(255, 255, 255, 1),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(22, 34, 51, 0.08),
                                  spreadRadius: 0,
                                  blurStyle: BlurStyle.solid,
                                  blurRadius: 16,
                                  offset: Offset(5, 5))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              gromming[5]['image']!,
                              width: 150,
                              height: 150,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              gromming[5]['name']!,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(245, 146, 69, 1)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
