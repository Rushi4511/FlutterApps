import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Screen5 extends StatefulWidget {
  const Screen5({super.key});

  @override
  State<Screen5> createState() => _Screen5State();
}

class _Screen5State extends State<Screen5> {
  TextEditingController searchController2 = TextEditingController();

  List<Map<String, String>> ourServices = [
    {"name": "Vaccinations", "image": "assets/images/vaccinations.png"},
    {"name": "Operations", "image": "assets/images/operations.png"},
    {"name": "Behaviorials", "image": "assets/images/behaviorials.png"},
    {"name": "Dentistry", "image": "assets/images/dentistry.png"},
  ];
  List<Map<String, String>> specialists = [
    {
      "image": "assets/images/anna_Johnson.png",
      "name": "Dr. Anna Johanson",
      "specialist": "Veterinary Behavioral",
      "rating": "4.8",
      "distance": "1 km"
    },
    {
      "image": "assets/images/vernon.png",
      "name": "Dr. Vernon Chwe",
      "specialist": "Veterinary Surgery",
      "rating": "4.9",
      "distance": "1.5 km"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Row(
                children: [
                  Icon(Icons.location_on,
                      color: Color.fromRGBO(245, 146, 69, 1)),
                  const SizedBox(width: 5),
                  Text(
                    "London, UK",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 415,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color.fromRGBO(245, 146, 69, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Lets Find Specialist \nDoctor for Your Pet!",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Image.asset(
                          "assets/images/screen5_1.png",
                          width: 140,
                          height: 140,
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: searchController2,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  suffixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
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
                    fontSize: 12,
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "See All",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 135,
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {}, // Add your navigation here
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.asset(
                              ourServices[index % 4]["image"]!,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              ourServices[index % 4]["name"]!,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(245, 146, 69, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Text(
                "Best Specialists Nearby",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: specialists.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                    child: Container(
                      height: 125,
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
                            offset: Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            specialists[index]["image"]!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                specialists[index]["name"]!,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                specialists[index]["specialist"]!,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Icon(Icons.star_border,
                                      color: Color.fromRGBO(245, 146, 69, 1)),
                                  Text(
                                    specialists[index]["rating"]!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(Icons.location_on,
                                      color: Color.fromRGBO(245, 146, 69, 1)),
                                  Text(
                                    specialists[index]["distance"]!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blueGrey,
                                    ),
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
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(eccentricity: BorderSide.strokeAlignCenter),
        onPressed: () {},
        backgroundColor: Color.fromRGBO(245, 146, 69, 1),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Icon(
              Icons.shopping_cart,
              semanticLabel: "Cart",
              color: Colors.white,
              size: 30,
            ),
            const Text(
              "Cart",
              style: TextStyle(fontSize: 12, color: Colors.white),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Color.fromRGBO(245, 146, 69, 1),
        unselectedItemColor: Colors.blueGrey,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: "Services",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
