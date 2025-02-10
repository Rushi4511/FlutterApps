import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Screen4 extends StatefulWidget {
  const Screen4({super.key});

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  List dates = ["Today", "21 September", "15 September", "10 September"];

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
          "Notifications",
          style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(31, 32, 41, 1)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                dates[index],
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(31, 32, 41, 1)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(252, 219, 193, 1),
                                    borderRadius: BorderRadius.circular(15)),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.shopping_bag_outlined,
                                      color: Color.fromRGBO(245, 146, 69, 1),
                                    )),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Your checkout is successfull, product is \non tne way",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(31, 32, 41, 1)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(252, 219, 193, 1),
                                    borderRadius: BorderRadius.circular(15)),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.done,
                                      color: Color.fromRGBO(245, 146, 69, 1),
                                    )),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Appointment request accepted",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(31, 32, 41, 1)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(252, 219, 193, 1),
                                    borderRadius: BorderRadius.circular(15)),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.favorite_border,
                                      color: Color.fromRGBO(245, 146, 69, 1),
                                    )),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Vaccinate your pet timely6",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(31, 32, 41, 1)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
