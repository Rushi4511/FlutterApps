import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Screen9 extends StatefulWidget {
  const Screen9({super.key});

  @override
  State<Screen9> createState() => _Screen9State();
}

class _Screen9State extends State<Screen9> {
  List<Map<String, String>> training = [
    {
      "image": "assets/images/training1.png",
      "courseName": "Obedience Courses",
      "ownerOfCourse": "By Jhon Smith",
      "rating": "4.9 (335)",
    },
    {
      "image": "assets/images/training2.png",
      "courseName": "Specialty Classes & \nWorkshops",
      "ownerOfCourse": "By Duke Fuzzington",
      "rating": "5.0 (500)"
    },
    {
      "image": "assets/images/training3.png",
      "courseName": "Puppy Kinderganten \nand Playgroups",
      "ownerOfCourse": "By Sir Fluffington",
      "rating": "5.0 (500)"
    },
    {
      "image": "assets/images/training4.png",
      "courseName": "Canine Good Citizen Test",
      "ownerOfCourse": "By Baron Fuzzypaws",
      "rating": "4.8 (220)"
    },
    {
      "image": "assets/images/training5.png",
      "courseName": "Theraphy Dogs",
      "ownerOfCourse": "By Duke Fuzzington",
      "rating": "5.0 (500)"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 232, 232, 1),
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
          "Trainings",
          style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(31, 32, 41, 1)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                    child: Container(
                      height: 150,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(22, 34, 51, 0.08),
                                spreadRadius: -8,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 16,
                                offset: Offset(5, 5))
                          ]),
                      child: Row(
                        children: [
                          Image.asset(
                            training[index % 5]["image"]!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                training[index % 5]["courseName"]!,
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                training[index % 5]["ownerOfCourse"]!,
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_border,
                                    color: Color.fromRGBO(245, 146, 69, 1),
                                  ),
                                  Text(
                                    training[index % 5]["rating"]!,
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.blueGrey),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
