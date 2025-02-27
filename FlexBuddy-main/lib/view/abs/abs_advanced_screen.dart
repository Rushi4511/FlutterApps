import 'package:flex_buddy/view/exercise%20bottomsheets/abdominal_crunches.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/bicycle_crunches.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/butt_bridge.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/cobra_stretch.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/crossover_crunches.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/heel_touch.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/jumping_jacks.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/mountain_climber.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/plank.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/pushup_and_rotation.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/russian_twist.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/side_bridges_right.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/side_briges_left.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/side_plank_left.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/side_plank_right.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/sit_ups.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/spine_lumber_left.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/spine_lumber_right.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/v_up.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Model class for Exercise
class AbsAdvancedModel {
  final String name;
  final String count;
  final String imagePath;

  AbsAdvancedModel({
    required this.name,
    required this.count,
    required this.imagePath,
  });
}

class AbsAdvancedScreen extends StatelessWidget {
  const AbsAdvancedScreen({super.key});

  final bool exerciseStarted = false;
  @override
  Widget build(BuildContext context) {
    // List of exercises
    final List<AbsAdvancedModel> exercises = [
      AbsAdvancedModel(
        name: 'Jumping Jacks',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/jumping_jacks.gif',
      ),
      AbsAdvancedModel(
        name: 'Sit-Ups',
        count: 'x20',
        imagePath: 'assets/images/exercise_gif/sit_ups.gif',
      ),
      AbsAdvancedModel(
        name: 'Side Bridges Left',
        count: 'x20',
        imagePath: 'assets/images/exercise_gif/side_bridges_left.gif',
      ),
      AbsAdvancedModel(
        name: 'Side Bridges Right',
        count: 'x20',
        imagePath: 'assets/images/exercise_gif/side_bridges_right.gif',
      ),
      AbsAdvancedModel(
        name: 'Abdominal Crunches',
        count: 'x30',
        imagePath: 'assets/images/exercise_gif/abdominal_crunches.gif',
      ),
      AbsAdvancedModel(
        name: 'Bicycle Crunches',
        count: 'x24',
        imagePath: 'assets/images/exercise_gif/bicycle_crunches.gif',
      ),
      AbsAdvancedModel(
        name: 'Side Plank Right',
        count: '00:20',
        imagePath: 'assets/images/exercise_gif/side_plank_right.gif',
      ),
      AbsAdvancedModel(
        name: 'Side Plank Left',
        count: '00:20',
        imagePath: 'assets/images/exercise_gif/side_plank_left.gif',
      ),
      AbsAdvancedModel(
        name: 'V-Up',
        count: 'x18',
        imagePath: 'assets/images/exercise_gif/v_up.gif',
      ),
      AbsAdvancedModel(
        name: 'Push-Up & Rotation',
        count: 'x24',
        imagePath: 'assets/images/exercise_gif/push_up_and_rotation.gif',
      ),
      AbsAdvancedModel(
        name: 'Russian Twist',
        count: 'x48',
        imagePath: 'assets/images/exercise_gif/russian_twist.gif',
      ),
      AbsAdvancedModel(
        name: 'Abdominal Crunches',
        count: 'x28',
        imagePath: 'assets/images/exercise_gif/abdominal_crunches.gif',
      ),
      AbsAdvancedModel(
        name: 'Butt Bridge',
        count: 'x30',
        imagePath: 'assets/images/exercise_gif/butt_bridge.gif',
      ),
      AbsAdvancedModel(
        name: 'Heel Touch',
        count: 'x34',
        imagePath: 'assets/images/exercise_gif/heel_touch.gif',
      ),
      AbsAdvancedModel(
        name: 'Mountain Climber',
        count: 'x30',
        imagePath: 'assets/images/exercise_gif/mountain_climber.gif',
      ),
      AbsAdvancedModel(
        name: 'Crossover Crunch',
        count: 'x24',
        imagePath: 'assets/images/exercise_gif/crossover_crunch.gif',
      ),
      AbsAdvancedModel(
        name: 'V-Up',
        count: 'x16',
        imagePath: 'assets/images/exercise_gif/v_up.gif',
      ),
      AbsAdvancedModel(
        name: 'Plank',
        count: '01:00',
        imagePath: 'assets/images/exercise_gif/plank.gif',
      ),
      AbsAdvancedModel(
        name: 'Cobra Stretch',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/cobra_stretch.gif',
      ),
      AbsAdvancedModel(
        name: 'Spine Lumber Twist\nStretch Left',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/spine_lumber_twist_stretch_left.gif',
      ),
      AbsAdvancedModel(
        name: 'Spine Lumber Twist\nStretch Right',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/spine_lumber_twist_stretch_right.gif',
      ),
    ];

    List exerciseBottomsheets = [
      const JumpingJacks(),const SitUps(),const SideBridgesLeft(),const SideBridgesRight(),const Abdominalcrunches(),const BicycleCrunches(),const SidePlankRight(),const SidePlankLeft(),const Vup(),const PushupAndRotation(),const RussianTwist(),const Abdominalcrunches(),const ButtBridge(),const HeelTouch(),const MountainClimber(),const CrossoverCrunches(),const Vup(),const Plank(),const CobraStretch(),const SpineLumberLeft(),const SpineLumberRight()  
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
                'ABS ADVANCED',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: Image.asset(
                'assets/images/abs.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(  
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: Row(
                children: [
                  Text(
                    '36 mins • 21 Workouts',
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => exerciseBottomsheets[index]
                      ),
                    );
                    // ExerciseBottomSheet.show(context);
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
      bottomNavigationBar: exerciseStarted ? Container(
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
                    style: GoogleFonts.montserrat(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
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
                        style: GoogleFonts.montserrat(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '6% completed',
                        style: GoogleFonts.montserrat(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ) : Container(
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
                    minimumSize: const Size(200,65),
                    maximumSize: const Size(200,65),
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'START',
                    style: GoogleFonts.montserrat(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              
            ],
          ),
        ) ,
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
                  const SizedBox(height: 5,),
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
