import 'package:flex_buddy/view/details_screen/goal_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscle_selector/muscle_selector.dart';

class FocusBodyParts extends StatefulWidget {
  const FocusBodyParts({super.key});

  @override
  State createState() => _FocusBodyPartsState();
}

class _FocusBodyPartsState extends State<FocusBodyParts> {
  // List<String> fullBody = const [
  //   'chest',
  //   'glutes',
  //   'neck',
  //   'lower_back',
  //   'abs',
  //   'biceps',
  //   'shoulders',
  //   'forearm',
  //   'triceps',
  //   'obliques',
  //   'trapezius',
  //   'lats',
  //   'adductors',
  //   'quads',
  //   'abductor',
  //   'calves',
  //   'harmstrings'
  // ];
  // List<String> back = const ['trapezius', 'lats', 'lower_back'];
  // List<String> shoulder = const ['shoulders'];
  // List<String> chest = const ['chest'];
  // List<String> butt = const ['glutes'];
  // List<String> abs = const ['abs', 'obliques'];
  // List<String> legs = const [
  //   'adductors',
  //   'quads',
  //   'abductor',
  //   'harmstrings',
  //   'calves'
  // ];
  // List<String> arm = const ['biceps', 'forearm', 'triceps'];

  Set<Muscle>? selectedMuscles;
  final GlobalKey<MusclePickerMapState> _mapKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Text(
                "Please Select The area\nyou want to focus on",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: 24,
                    color: Colors.white,
                    height: 1.5,
                    fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: InteractiveViewer(
                  scaleEnabled: true,
                  panEnabled: true,
                  constrained: true,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 35),
                    child: Align(
                      alignment: Alignment.center,
                      child: Transform.scale(
                        scaleX: 1.25,
                        scaleY: 1.35,
                        child: MusclePickerMap(
                          key: _mapKey,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          map: Maps.BODY,
                          isEditing: false,
                          initialSelectedGroups: const [],
                          onChanged: (muscles) {
                            setState(() {
                              selectedMuscles = muscles;
                            });
                          },
                          actAsToggle: true,
                          dotColor: Colors.white,
                          selectedColor: Colors.red,
                          strokeColor: Colors.white60,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Container(
                    width: 250,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.grey.shade600,
                          Colors.grey.shade800,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF9796F0).withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const GoalScreen(),
                        ));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "Continue",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
