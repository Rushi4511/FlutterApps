import 'package:flex_buddy/exercise_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Model class for Exercise
class ArmBeginnerModel {
  final String name;
  final String count;
  final String imagePath;

  ArmBeginnerModel({
    required this.name,
    required this.count,
    required this.imagePath,
  });
}

class ArmBeginnerScreen extends StatelessWidget {
  const ArmBeginnerScreen({super.key});

  final bool exerciseStarted = false;
  @override
  Widget build(BuildContext context) {
    // List of exercises
    final List<ArmBeginnerModel> exercises = [
      ArmBeginnerModel(
        name: 'Arm Raises',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/GIF/Arm_raises.gif',
      ),
      ArmBeginnerModel(
        name: 'Side Arm Raise',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/GIF/Side_arm_raise.gif',
      ),
      ArmBeginnerModel(
        name: 'Triceps Dips',
        count: '×10',
        imagePath: 'assets/images/exercise_gif/GIF/Triceps_dips.gif',
      ),
      ArmBeginnerModel(
        name: 'Arm Cicles Clockwise',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/GIF/Arm_circles_cloclkwise.gif',
      ),
      ArmBeginnerModel(
        name: 'Arm Circles Counterclockwise',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/GIF/Arm_circles_cloclkwise.gif',
      ),
      ArmBeginnerModel(
        name: 'Diamond Push-Ups',
        count: 'x6',
        imagePath: 'assets/images/exercise_gif/GIF/Diamond_push_ups.gif',
      ),
      ArmBeginnerModel(
        name: 'Jumping Jacks',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/jumping_jacks.gif',
      ),
      ArmBeginnerModel(
        name: 'Chest Press Pulse',
        count: '00:16',
        imagePath: 'assets/images/exercise_gif/GIF/Chest_press_pulse.gif',
      ),
      ArmBeginnerModel(
        name: 'Leg Barbell Curl Left',
        count: '×8',
        imagePath: 'assets/images/exercise_gif/GIF/Leg_barbell_curl_left.gif',
      ),
      ArmBeginnerModel(
        name: 'Leg Barbell Curl Right',
        count: '×8',
        imagePath: 'assets/images/exercise_gif/GIF/Leg_barbell_curl_right.gif',
      ),
      ArmBeginnerModel(
        name: 'Diagonal Plank',
        count: '×10',
        imagePath: 'assets/images/exercise_gif/GIF/Diagonal_plank.gif',
      ),
      ArmBeginnerModel(
        name: 'Punches',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/GIF/Punches.gif',
      ),
      ArmBeginnerModel(
        name: 'Push-Ups',
        count: '×10',
        imagePath: 'assets/images/exercise_gif/GIF/Push_ups.gif',
      ),
      ArmBeginnerModel(
        name: 'Inchworms',
        count: '×8',
        imagePath: 'assets/images/exercise_gif/GIF/Inchworms.gif',
      ),
      ArmBeginnerModel(
        name: 'Wall Push-Ups',
        count: '×12',
        imagePath: 'assets/images/exercise_gif/GIF/Wall_push_ups.gif',
      ),
      ArmBeginnerModel(
        name: 'Triceps Stretch Left',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/GIF/Triceps_stretch_left.gif',
      ),
      ArmBeginnerModel(
        name: 'Triceps Stretch Right',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/GIF/Triceps_stretch_right.gif',
      ),
      ArmBeginnerModel(
        name: 'Standing Biceps Stretch Left',
        count: '00:30',
        imagePath:
            'assets/images/exercise_gif/GIF/Standing_biceps_stretch_left.gif',
      ),
      ArmBeginnerModel(
        name: 'Standing Biceps Stretch Right',
        count: '00:30',
        imagePath:
            'assets/images/exercise_gif/GIF/Standing_biceps_stretch_right.gif',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            expandedHeight: 220.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Text(
                'ARM BEGINNER',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: Image.asset(
                'assets/images/arm1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: Row(
                children: [
                  Text(
                    '17 mins • 19 Workouts',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == exercises.length) {
                  return const SizedBox(height: 80); // Bottom padding
                }
                final exercise = exercises[index];
                return GestureDetector(
                  onTap: () {
                    // // Navigate to exercise detail page
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ExerciseDetailPage(exercise: exercise),
                    //   ),
                    // );
                    ExerciseBottomSheet.show(context);
                  },
                  child: ExerciseItem(
                    name: exercise.name,
                    count: exercise.count,
                    imagePath: exercise.imagePath,
                  ),
                );
              },
              childCount: exercises.length + 1, // +1 for bottom padding
            ),
          ),
        ],
      ),
      bottomNavigationBar: exerciseStarted
          ? Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white24),
                color: Colors.black,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 75),
                        maximumSize: const Size(200, 75),
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Restart',
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 75),
                        maximumSize: const Size(200, 75),
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Continue',
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '6% completed',
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white24),
                color: Colors.black,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 65),
                        maximumSize: const Size(200, 65),
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'START',
                        style: GoogleFonts.montserrat(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ExerciseItem extends StatelessWidget {
  final String name;
  final String count;
  final String imagePath;

  const ExerciseItem({
    super.key,
    required this.name,
    required this.count,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.black54,
        child: Row(
          children: [
            SizedBox(
              width: 115,
              height: 100,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    count,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}