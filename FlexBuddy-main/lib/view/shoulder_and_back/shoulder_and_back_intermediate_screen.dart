import 'package:flex_buddy/exercise_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoulderAndBackIntermediateModel {
  final String name;
  final String count;
  final String imagePath;

  ShoulderAndBackIntermediateModel({
    required this.name,
    required this.count,
    required this.imagePath,
  });
}

class ShoulderAndBackIntermediateScreen extends StatelessWidget {
  const ShoulderAndBackIntermediateScreen({super.key});

  final bool exerciseStarted = false;
  @override
  Widget build(BuildContext context) {
    // List of exercises
    final List<ShoulderAndBackIntermediateModel> exercises = [
      ShoulderAndBackIntermediateModel(
        name: 'Jumping Jacks',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/jumping_jacks.gif',
      ),
      ShoulderAndBackIntermediateModel(
        name: 'Arm Raises',
        count: '00:16',
        imagePath: 'assets/images/exercise_gif/GIF/Arm_raises.gif',
      ),
      ShoulderAndBackIntermediateModel(
        name: 'Rhomboid Pulls',
        count: '×14',
        imagePath: 'assets/images/exercise_gif/GIF/Rhomboid_pulls.gif',
      ),
      ShoulderAndBackIntermediateModel(
        name: 'Side Arm Raises',
        count: '00:16',
        imagePath: 'assets/images/exercise_gif/GIF/Side_arm_raise.gif',
      ),
      ShoulderAndBackIntermediateModel(
        name: 'Knee Push-Ups',
        count: '×14',
        imagePath: 'assets/images/exercise_gif/GIF/Knee_push_ups.gif',
      ),
      ShoulderAndBackIntermediateModel(
        name: 'Side-Lying Floor Stretch Left',
        count: '00:30',
        imagePath:
            'assets/images/exercise_gif/GIF/Side_lying_floor_stretch_left.gif',
      ),
      ShoulderAndBackIntermediateModel(
        name: 'Side-Lying Floor Stretch Right',
        count: '00:30',
        imagePath:
            'assets/images/exercise_gif/GIF/Side_lying_floor_stretch_right.gif',
      ),
      ShoulderAndBackIntermediateModel(
        name: 'Arm Scissors',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/GIF/Arm_scissors.gif',
      ),
      ShoulderAndBackIntermediateModel(
        name: 'Rhomboid Pulls',
        count: '×12',
        imagePath: 'assets/images/exercise_gif/GIF/Rhomboid_pulls.gif',
      ),
      ShoulderAndBackIntermediateModel(
        name: 'Side Arm Raises',
        count: '00:14',
        imagePath: 'assets/images/exercise_gif/GIF/Side_arm_raise.gif',
      ),
      ShoulderAndBackIntermediateModel(
        name: 'Knee Push-Ups',
        count: '×12',
        imagePath: 'assets/images/exercise_gif/GIF/Knee_push_ups.gif',
      ),
      ShoulderAndBackIntermediateModel(
        name: 'Cat Cow Pose',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/GIF/Cat_cow_pose.gif',
      ),
      ShoulderAndBackIntermediateModel(
        name: 'Prone Triceps Push Ups',
        count: 'x14',
        imagePath: 'assets/images/exercise_gif/GIF/Prone_triceps_push_ups.gif',
      ),
      ShoulderAndBackIntermediateModel(
        name: 'Reclined Rhomboidal Squeezes',
        count: 'x12',
        imagePath:
            'assets/images/exercise_gif/GIF/Reclined_rhomboid_squeezes.gif',
      ),
      ShoulderAndBackIntermediateModel(
        name: 'Prone Triceps Push Ups',
        count: 'x14',
        imagePath: 'assets/images/exercise_gif/GIF/Prone_triceps_push_ups.gif',
      ),
      ShoulderAndBackIntermediateModel(
        name: 'Reclined Rhomboidal Squeezes',
        count: 'x12',
        imagePath:
            'assets/images/exercise_gif/GIF/Reclined_rhomboid_squeezes.gif',
      ),
      ShoulderAndBackIntermediateModel(
        name: "Child's Pose",
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/GIF/Childs_pose.gif',
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
                'SHOULDER AND BACK INTERMEDIATE',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: Image.asset(
                'assets/images/back1.jpg',
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
                    '17 mins • 17 Workouts',
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
              width: 100,
              height: 100,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
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