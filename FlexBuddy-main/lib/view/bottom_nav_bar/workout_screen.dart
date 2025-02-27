// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_buddy/colors.dart';
import 'package:flex_buddy/controller/sessions.dart';
import 'package:flex_buddy/view/abs/abs_advanced_screen.dart';
import 'package:flex_buddy/view/abs/abs_beginner_screen.dart';
import 'package:flex_buddy/view/abs/abs_intermediate_screen.dart';
import 'package:flex_buddy/view/arm/arm_advanced_screen.dart';
import 'package:flex_buddy/view/arm/arm_beginner_screen.dart';
import 'package:flex_buddy/view/arm/arm_intermediate_screen.dart';
import 'package:flex_buddy/view/chest/chest_advanced_screen.dart';
import 'package:flex_buddy/view/chest/chest_beginner_screen.dart';
import 'package:flex_buddy/view/chest/chest_intermediate_screen.dart';
import 'package:flex_buddy/view/legs/legs_advanced_screen.dart';
import 'package:flex_buddy/view/legs/legs_beginner_screen.dart';
import 'package:flex_buddy/view/legs/legs_intermediate_screen.dart';
import 'package:flex_buddy/view/shoulder_and_back/shoulder_and_back_advanced_screen.dart';
import 'package:flex_buddy/view/shoulder_and_back/shoulder_and_back_beginner_screen.dart';
import 'package:flex_buddy/view/shoulder_and_back/shoulder_and_back_intermediate_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> with SingleTickerProviderStateMixin {
  
  late String email;
  String? name;
  bool isLoading = true;

  List BEGINNER = [
    const AbsBeginnerScreen(),const ChestBeginnerScreen(),const ArmBeginnerScreen(),const LegsBeginnerScreen(),const ShoulderAndBackBeginnerScreen()
  ];

  List INTERMEDIATE = [
    const AbsIntermediateScreen(),const ChestIntermediateScreen(),const ArmIntermediateScreen(),const LegsIntermediateScreen(),const ShoulderAndBackIntermediateScreen()
  ];

  List ADVANCED = [
    const AbsAdvancedScreen(),const ChestAdvancedScreen(),const ArmAdvancedScreen(),const LegsAdvancedScreen(),const ShoulderAndBackAdvancedScreen()
  ];

  final List<Map<String, String>> workoutList = [
    {
      'name': 'ABS',
      'begMins': '20',
      'interMins': '29',
      'advMins': '36',
      'begCount': '16',
      'interCount': '21',
      'advCount': '21',
      'image': 'assets/images/abs_beg.jpg',
      'color1': '#FFF700',
      'color2': '#FFB800'
    },
    {
      'name': 'CHEST',
      'begMins': '9',
      'interMins': '15',
      'advMins': '19',
      'begCount': '11',
      'interCount': '14',
      'advCount': '16',
      'image': 'assets/images/chest.jpg',
      'color1': '#FFD700',
      'color2': '#FFA500'
    },
    {
      'name': 'ARMS',
      'begMins': '17',
      'interMins': '26',
      'advMins': '32',
      'begCount': '19',
      'interCount': '25',
      'advCount': '28',
      'image': 'assets/images/arm4.jpg',
      'color1': '#FFFF00',
      'color2': '#FFA500'
    },
    {
      'name': 'LEG',
      'begMins': '26',
      'interMins': '41',
      'advMins': '53',
      'begCount': '23',
      'interCount': '36',
      'advCount': '43',
      'image': 'assets/images/legs.jpg',
      'color1': '#FFD700',
      'color2': '#FFA800'
    },
    {
      'name': 'SHOULDER\nAND BACK',
      'begMins': '17',
      'interMins': '19',
      'advMins': '17',
      'begCount': '17',
      'interCount': '17',
      'advCount': '17',
      'image': 'assets/images/back2.jpg',
      'color1': '#FFEB3B',
      'color2': '#FFC107'
    },
  ];

  Future<void> getUserName(String email) async {
    try {
      final firestore = FirebaseFirestore.instance;
      DocumentSnapshot docSnapshot = await firestore.collection('Users').doc(email).get();

      if (docSnapshot.exists) {
        setState(() {
          name = docSnapshot.get('name');
          isLoading = false; // Data loaded
          log(name!);
        });
      } else {
        log('Document does not exist');
        setState(() {
          name = "Guest"; // Fallback name
          isLoading = false;
        });
      }
    } catch (e) {
      log('Error fetching name: $e');
      setState(() {
        name = "Error"; // Error fallback
        isLoading = false;
      });
    }
  }

  Future<void> collectData() async {
    await SessionData.getSessionData();
    email = SessionData.emailId;
    log("-------------On Home Screen $email");

    await getUserName(email);
  }

  @override
  void initState() {
    super.initState();
    collectData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              _buildHeader(),
              const SizedBox(height: 5),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    levelWorkoutScreen(level: "BEGINNER"),
                    levelWorkoutScreen(level: "INTERMEDIATE"),
                    levelWorkoutScreen(level: "ADVANCED"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, $name",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: MyColors.yellow
                ),
              ),
              const SizedBox(height: 5,),
              Text(
                "Choose your workout plan",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFC107).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.fitness_center,
              color: MyColors.yellow,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ButtonsTabBar(
        backgroundColor: Colors.yellow.withOpacity(0.9), // Bright yellow
        unselectedBackgroundColor: Colors.white,
        labelStyle: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        borderWidth: 1,
        unselectedBorderColor: Colors.black,
        radius: 50,
        height: 50,
        width: 140,
        contentCenter: true,
        tabs: const [
          Tab(text: "Beginner",),
          Tab(text: "Intermediate"),
          Tab(text: "Advanced"),
        ],
      ),
    );
  }

  Widget levelWorkoutScreen({required String level}) {
    List getScreens() {
      switch (level) {
        case "BEGINNER":
          return BEGINNER;
        case "INTERMEDIATE":
          return INTERMEDIATE;
        case "ADVANCED":
          return ADVANCED;
        default:
          return BEGINNER;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            "Let's Go $level",
            style: GoogleFonts.poppins(
              color: MyColors.yellow,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Explore Different Workout Styles',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: workoutList.length,
              itemBuilder: (context, index) {
                final screens = getScreens();
                return _buildWorkoutCard(index, screens, level);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard(int index, List screens, String level) {
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: screens[index],
          withNavBar: false,
        );
        
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.2),
              // Colors.black.withOpacity(0.4),
            ],
          ),
          border: Border.all(
            color: MyColors.yellow.withOpacity(0.3),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    width: 110,
                    height: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(workoutList[index]['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workoutList[index]['name']!,
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: MyColors.yellow
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              _buildInfoChip(
                                Icons.timer,
                                "${workoutList[index]['begMins']} mins",
                              ),
                              const SizedBox(width: 12),
                              _buildInfoChip(
                                Icons.fitness_center,
                                "${workoutList[index]['begCount']} exercises",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 16,
                top: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: MyColors.yellow.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    level,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.white
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}



// import 'dart:developer';

// import 'package:buttons_tabbar/buttons_tabbar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flex_buddy/controller/sessions.dart';
// import 'package:flex_buddy/view/abs/abs_advanced_screen.dart';
// import 'package:flex_buddy/view/abs/abs_beginner_screen.dart';
// import 'package:flex_buddy/view/abs/abs_intermediate_screen.dart';
// import 'package:flex_buddy/view/arm/arm_advanced_screen.dart';
// import 'package:flex_buddy/view/arm/arm_beginner_screen.dart';
// import 'package:flex_buddy/view/arm/arm_intermediate_screen.dart';
// import 'package:flex_buddy/view/chest/chest_advanced_screen.dart';
// import 'package:flex_buddy/view/chest/chest_beginner_screen.dart';
// import 'package:flex_buddy/view/chest/chest_intermediate_screen.dart';
// import 'package:flex_buddy/view/legs/legs_advanced_screen.dart';
// import 'package:flex_buddy/view/legs/legs_beginner_screen.dart';
// import 'package:flex_buddy/view/legs/legs_intermediate_screen.dart';
// import 'package:flex_buddy/view/shoulder%20and%20back/shoulder_and_back_advanced_screen.dart';
// import 'package:flex_buddy/view/shoulder%20and%20back/shoulder_and_back_beginner_screen.dart';
// import 'package:flex_buddy/view/shoulder%20and%20back/shoulder_and_back_intermediate_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

// class WorkoutScreen extends StatefulWidget {
//   const WorkoutScreen({super.key});

//   @override
//   State createState() => _WorkoutScreenState();
// }

// class _WorkoutScreenState extends State<WorkoutScreen> with SingleTickerProviderStateMixin {
  
//   late String email;
//   String? name;
//   bool isLoading = true;

//   List BEGINNER = [
//     const AbsBeginnerScreen(),const ChestBeginnerScreen(),const ArmBeginnerScreen(),const LegsBeginnerScreen(),const ShoulderAndBackBeginnerScreen()
//   ];

//   List INTERMEDIATE = [
//     const AbsIntermediateScreen(),const ChestIntermediateScreen(),const ArmIntermediateScreen(),const LegsIntermediateScreen(),const ShoulderAndBackIntermediateScreen()
//   ];

//   List ADVANCED = [
//     const AbsAdvancedScreen(),const ChestAdvancedScreen(),const ArmAdvancedScreen(),const LegsAdvancedScreen(),const ShoulderAndBackAdvancedScreen()
//   ];

//   final List<Map<String, String>> workoutList = [
//     {
//       'name': 'ABS',
//       'mins': '20',
//       'count': '16',
//       'image': 'assets/images/man.jpg',
//       'color1': '#FFA500',
//       'color2': '#FF8C00'
//     },
//     {
//       'name': 'CHEST',
//       'mins': '9',
//       'count': '11',
//       'image': 'assets/images/man.jpg',
//       'color1': '#FFD580',
//       'color2': '#FFAA33'
//     },
//     {
//       'name': 'ARMS',
//       'mins': '17',
//       'count': '19',
//       'image': 'assets/images/man.jpg',
//       'color1': '#FFC872',
//       'color2': '#FFA07A'
//     },
//     {
//       'name': 'LEG',
//       'mins': '26',
//       'count': '23',
//       'image': 'assets/images/man.jpg',
//       'color1': '#FFB74D',
//       'color2': '#FF9800'
//     },
//     {
//       'name': 'SHOULDER AND BACK',
//       'mins': '17',
//       'count': '17',
//       'image': 'assets/images/man.jpg',
//       'color1': '#FFCC80',
//       'color2': '#FF9966'
//     },
//   ];

//   Future<void> getUserName(String email) async {
//     try {
//       final firestore = FirebaseFirestore.instance;
//       DocumentSnapshot docSnapshot = await firestore.collection('Users').doc(email).get();

//       if (docSnapshot.exists) {
//         setState(() {
//           name = docSnapshot.get('name');
//           isLoading = false; // Data loaded
//           log(name!);
//         });
//       } else {
//         print('Document does not exist');
//         setState(() {
//           name = "Guest"; // Fallback name
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print('Error fetching name: $e');
//       setState(() {
//         name = "Error"; // Error fallback
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> collectData() async {
//     await SessionData.getSessionData();
//     email = SessionData.emailId;
//     log("-------------On Home Screen $email");

//     await getUserName(email);
//   }

//   @override
//   void initState() {
//     super.initState();
//     collectData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: DefaultTabController(
//           length: 3,
//           child: Column(
//             children: <Widget>[
//               _buildHeader(),
//               const SizedBox(height: 20),
//               _buildTabBar(),
//               Expanded(
//                 child: TabBarView(
//                   children: <Widget>[
//                     levelWorkoutScreen(level: "BEGINNER"),
//                     levelWorkoutScreen(level: "INTERMEDIATE"),
//                     levelWorkoutScreen(level: "ADVANCED"),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Hi, $name",
//                 style: GoogleFonts.poppins(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: const Color(0xFFFF5722), // Deep Orange accent
//                 ),
//               ),
//               Text(
//                 "Choose your workout plan",
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                   color: const Color(0xFFFF7043).withOpacity(0.7),
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: const Color(0xFFFF5722).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               Icons.fitness_center,
//               color: const Color(0xFFFF5722),
//               size: 24,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: ButtonsTabBar(
//         backgroundColor: const Color(0xFFFF5722), // Deep Orange
//         unselectedBackgroundColor: Colors.transparent,
//         labelStyle: GoogleFonts.poppins(
//           color: Colors.white,
//           fontWeight: FontWeight.w600,
//         ),
//         unselectedLabelStyle: GoogleFonts.poppins(
//           color: const Color(0xFFFF5722),
//           fontWeight: FontWeight.w600,
//         ),
//         borderWidth: 1,
//         unselectedBorderColor: const Color(0xFFFF5722),
//         radius: 100,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//         height: 50,
//         tabs: const [
//           Tab(text: "Beginner"),
//           Tab(text: "Intermediate"),
//           Tab(text: "Advanced"),
//         ],
//       ),
//     );
//   }

//   Widget levelWorkoutScreen({required String level}) {
//     List getScreens() {
//       switch (level) {
//         case "BEGINNER":
//           return BEGINNER;
//         case "INTERMEDIATE":
//           return INTERMEDIATE;
//         case "ADVANCED":
//           return ADVANCED;
//         default:
//           return BEGINNER;
//       }
//     }

//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Let's Go $level",
//             style: GoogleFonts.poppins(
//               color: const Color(0xFFFF5722),
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Explore Different Workout Styles',
//             style: GoogleFonts.poppins(
//               color: const Color(0xFFFF7043).withOpacity(0.7),
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(height: 20),
//           Expanded(
//             child: ListView.builder(
//               physics: const BouncingScrollPhysics(),
//               itemCount: workoutList.length,
//               itemBuilder: (context, index) {
//                 final screens = getScreens();
//                 return _buildWorkoutCard(index, screens, level);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildWorkoutCard(int index, List screens, String level) {
//     return GestureDetector(
//       onTap: () {
//         PersistentNavBarNavigator.pushNewScreen(
//           context,
//           screen: screens[index],
//           withNavBar: false,
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               const Color(0xFFFF5722).withOpacity(0.1),
//               const Color(0xFFFF5722).withOpacity(0.2),
//             ],
//           ),
//           border: Border.all(
//             color: const Color(0xFFFF5722).withOpacity(0.3),
//           ),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: Stack(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 120,
//                     height: 120,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage(workoutList[index]['image']!),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "${workoutList[index]['name']!}",
//                             style: GoogleFonts.poppins(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: const Color(0xFFFF5722),
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             children: [
//                               _buildInfoChip(
//                                 Icons.timer,
//                                 "${workoutList[index]['mins']} mins",
//                               ),
//                               const SizedBox(width: 12),
//                               _buildInfoChip(
//                                 Icons.fitness_center,
//                                 "${workoutList[index]['count']} exercises",
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Positioned(
//                 right: 16,
//                 top: 16,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFFF5722),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     level,
//                     style: GoogleFonts.poppins(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoChip(IconData icon, String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: const Color(0xFFFF5722).withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             size: 16,
//             color: const Color(0xFFFF5722),
//           ),
//           const SizedBox(width: 4),
//           Text(
//             label,
//             style: GoogleFonts.poppins(
//               color: const Color(0xFFFF5722),
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }