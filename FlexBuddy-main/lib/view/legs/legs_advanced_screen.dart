import 'package:flex_buddy/exercise_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Model class for Exercise
class LegsAdvancedModel {
  final String name;
  final String count;
  final String imagePath;

  LegsAdvancedModel({
    required this.name,
    required this.count,
    required this.imagePath,
  });
}

class LegsAdvancedScreen extends StatelessWidget {
  const LegsAdvancedScreen({super.key});

  final bool exerciseStarted = false;
  @override
  Widget build(BuildContext context) {
    // List of exercises
    final List<LegsAdvancedModel> exercises = [
      LegsAdvancedModel(
        name: 'Side Hop',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/GIF/Side_hop.gif',
      ),
      LegsAdvancedModel(
        name: 'Squats',
        count: 'x12',
        imagePath: 'assets/images/exercise_gif/GIF/Squats.gif',
      ),
      LegsAdvancedModel(
        name: 'Squats',
        count: 'x12',
        imagePath: 'assets/images/exercise_gif/GIF/Squats.gif',
      ),
      LegsAdvancedModel(
        name: 'Side-Lying Leg Lift Left',
        count: '×12',
        imagePath:
            'assets/images/exercise_gif/GIF/Side_lying_leg_lift_left.gif',
      ),
      LegsAdvancedModel(
        name: 'Side-Lying Leg Lift Right',
        count: '×12',
        imagePath:
            'assets/images/exercise_gif/GIF/Side_lying_leg_lift_right.gif',
      ),
      LegsAdvancedModel(
        name: 'Side-Lying Leg Lift Left',
        count: '×12',
        imagePath:
            'assets/images/exercise_gif/GIF/Side_lying_leg_lift_left.gif',
      ),
      LegsAdvancedModel(
        name: 'Side-Lying Leg Lift Right',
        count: '×12',
        imagePath:
            'assets/images/exercise_gif/GIF/Side_lying_leg_lift_right.gif',
      ),
      LegsAdvancedModel(
        name: 'Backward Lunge',
        count: '×14',
        imagePath: 'assets/images/exercise_gif/GIF/Backward_lunge.gif',
      ),
      LegsAdvancedModel(
        name: 'Backward Lunge',
        count: '×14',
        imagePath: 'assets/images/exercise_gif/GIF/Backward_lunge.gif',
      ),
      LegsAdvancedModel(
        name: 'Donkey Kicks Left',
        count: '×16',
        imagePath: 'assets/images/exercise_gif/GIF/Donkey_kicks_left.gif',
      ),
      LegsAdvancedModel(
        name: 'Donkey Kicks Right',
        count: '×16',
        imagePath: 'assets/images/exercise_gif/GIF/Donkey_kicks_left.gif',
      ),
      LegsAdvancedModel(
        name: 'Donkey Kicks Left',
        count: '×16',
        imagePath: 'assets/images/exercise_gif/GIF/Donkey_kicks_left.gif',
      ),
      LegsAdvancedModel(
        name: 'Donkey Kicks Right',
        count: '×16',
        imagePath: 'assets/images/exercise_gif/GIF/Donkey_kicks_left.gif',
      ),
      LegsAdvancedModel(
        name: 'Left Quad Stretch With Wall',
        count: '00:30',
        imagePath:
            'assets/images/exercise_gif/GIF/Left_quad_stretch_with_wall.gif',
      ),
      LegsAdvancedModel(
        name: 'Right Quad Stretch With Wall',
        count: '00:30',
        imagePath:
            'assets/images/exercise_gif/GIF/Right_quad_stretch_with_wall.gif',
      ),
      LegsAdvancedModel(
        name: 'Knee To Chest Stretch Left',
        count: '00:30',
        imagePath:
            'assets/images/exercise_gif/GIF/Knee_to_chest_stretch_left.gif',
      ),
      LegsAdvancedModel(
        name: 'Knee To Chest Stretch Right',
        count: '00:30',
        imagePath:
            'assets/images/exercise_gif/GIF/Knee_to_chest_stretch_right.gif',
      ),
      LegsAdvancedModel(
        name: 'Wall Calf Raises',
        count: '×12',
        imagePath: 'assets/images/exercise_gif/GIF/Wall_calf_raises.gif',
      ),
      LegsAdvancedModel(
        name: 'Wall Calf Raises',
        count: '×12',
        imagePath: 'assets/images/exercise_gif/GIF/Wall_calf_raises.gif',
      ),
      LegsAdvancedModel(
        name: 'Sumo Squat Calf Raises With Wall',
        count: '×12',
        imagePath:
            'assets/images/exercise_gif/GIF/Sumo_squat_caalf_raises_with_wall.gif',
      ),
      LegsAdvancedModel(
        name: 'Sumo Squat Calf Raises With Wall',
        count: '×12',
        imagePath:
            'assets/images/exercise_gif/GIF/Sumo_squat_caalf_raises_with_wall.gif',
      ),
      LegsAdvancedModel(
        name: 'Calf Stretch Left',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/GIF/Calf_stretch_left.gif',
      ),
      LegsAdvancedModel(
        name: 'Calf Stretch Right',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/GIF/Calf_stretch_left.gif',
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
                'LEGS ADVANCED',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: Image.asset(
                'assets/images/legs.jpg',
                fit: BoxFit.contain,
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
                    '26 mins • 23 Workouts',
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
              width: 120,
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