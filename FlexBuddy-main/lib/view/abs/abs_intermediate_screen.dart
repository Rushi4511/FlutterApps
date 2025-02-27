
import 'package:flex_buddy/view/abs/database/abs_beginner_database.dart';
import 'package:flex_buddy/view/abs/exercise_progress/abs_intermediate_exercise_progress.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/abdominal_crunches.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/cobra_stretch.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/heel_touch.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/jumping_jacks.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/leg_raises.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/mountain_climber.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/plank.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/russian_twist.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/spine_lumber_left.dart';
import 'package:flex_buddy/view/exercise%20bottomsheets/spine_lumber_right.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Model class for Exercise
class AbsIntermediateModel {
  final String name;
  final String count;
  final String imagePath;

  AbsIntermediateModel({
    required this.name,
    required this.count,
    required this.imagePath,
  });
}

class AbsIntermediateScreen extends StatefulWidget {
  static bool exerciseStarted = false;
  static int lastExerciseIndex = 0;
  
  static double getProgress() {
    return (lastExerciseIndex + 1) / 16 * 100; // 16 is total number of exercises
  }

  const AbsIntermediateScreen({super.key});

  @override
  State<AbsIntermediateScreen> createState() => _AbsIntermediateScreenState();
}

class _AbsIntermediateScreenState extends State<AbsIntermediateScreen> {
  
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializedWorkoutProgress();
  }

  Future<void> _initializedWorkoutProgress() async{

    await LocalDatabase.initializeDatabase();

    final progess = await LocalDatabase.getWorkoutProgress(tableName: 'AbsIntermediate');

    setState(() {
      AbsIntermediateScreen.exerciseStarted = progess['isStarted'];
      AbsIntermediateScreen.lastExerciseIndex = progess['currentIndex'];
      _isInitialized = true;
    });
  }

  void _startWorkout(List<AbsIntermediateModel> exercises, {int startIndex = 0}) async{
    
    await LocalDatabase.saveWorkoutProgress(tableName: 'AbsIntermediate',isStarted: true, currentIndex: startIndex, progress: (startIndex+1)/16*100);
    
    // ignore: use_build_context_synchronously
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AbsIntermediateExerciseProgressScreen(
          exercises: exercises,
          startIndex: startIndex,
        ),
      ),
    ).then((_) {
      // Update the UI when returning from exercise screen
      setState(() {});
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // List of exercises
    final List<AbsIntermediateModel> exercises = [
      AbsIntermediateModel(
        name: 'Russian Twist',
        count: '×20',
        imagePath: 'assets/images/exercise_gif/russian_twist.gif',
      ),
      AbsIntermediateModel(
        name: 'Jumping Jacks',
        count: '00:20',
        imagePath: 'assets/images/exercise_gif/jumping_jacks.gif',
      ),
      AbsIntermediateModel(
        name: 'Mountain Climber',
        count: '×16',
        imagePath: 'assets/images/exercise_gif/mountain_climber.gif',
      ),
      AbsIntermediateModel(
        name: 'Abdominal Crunches',
        count: '×16',
        imagePath: 'assets/images/exercise_gif/abdominal_crunches.gif',
      ),
      AbsIntermediateModel(
        name: 'Heel Touch',
        count: '×20',
        imagePath: 'assets/images/exercise_gif/heel_touch.gif',
      ),
      AbsIntermediateModel(
        name: 'Leg Raises',
        count: '×16',
        imagePath: 'assets/images/exercise_gif/leg_raises.gif',
      ),
      AbsIntermediateModel(
        name: 'Plank',
        count: '00:20',
        imagePath: 'assets/images/exercise_gif/plank.gif',
      ),
      AbsIntermediateModel(
        name: 'Abdominal Crunches',
        count: '×12',
        imagePath: 'assets/images/exercise_gif/abdominal_crunches.gif',
      ),
      AbsIntermediateModel(
        name: 'Russian Twist',
        count: '×32',
        imagePath: 'assets/images/exercise_gif/russian_twist.gif',
      ),
      AbsIntermediateModel(
        name: 'Mountain Climber',
        count: '×12',
        imagePath: 'assets/images/exercise_gif/mountain_climber.gif',
      ),
      AbsIntermediateModel(
        name: 'Heel Touch',
        count: '×20',
        imagePath: 'assets/images/exercise_gif/heel_touch.gif',
      ),
      AbsIntermediateModel(
        name: 'Leg Raises',
        count: '×14',
        imagePath: 'assets/images/exercise_gif/leg_raises.gif',
      ),
      AbsIntermediateModel(
        name: 'Plank',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/plank.gif',
      ),
      AbsIntermediateModel(
        name: 'Cobra Stretch',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/cobra_stretch.gif',
      ),
      AbsIntermediateModel(
        name: 'Spine Lumber Twist Stretch Left',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/spine_lumber_twist_stretch_left.gif',
      ),
      AbsIntermediateModel(
        name: 'Spine Lumber Twist Stretch Right',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/spine_lumber_twist_stretch_right.gif',
      ),
    ];

    List exerciseBottomsheets = [
      const RussianTwist(),const JumpingJacks(),const MountainClimber(),const Abdominalcrunches(),const HeelTouch(),const LegRaises(),const Plank(),const Abdominalcrunches(),const RussianTwist(),const MountainClimber(),const HeelTouch(),const LegRaises(),const Plank(),const CobraStretch(),const SpineLumberLeft(),const SpineLumberRight()
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
                'ABS INTERMEDIATE',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: Image.asset(
                'assets/images/abs1.jpg',
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
                    '20 mins • 16 Workouts',
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
      bottomNavigationBar: !_isInitialized ?
        const CircularProgressIndicator()
        :
       AbsIntermediateScreen.exerciseStarted 
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
                    onPressed: ()async{
                      await LocalDatabase.resetWorkoutProgress(tableName: 'AbsIntermediate',);
                      setState(() {
                        AbsIntermediateScreen.exerciseStarted = false;
                        AbsIntermediateScreen.lastExerciseIndex = 0;
                      });
                      _startWorkout(exercises);
                    },
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _startWorkout(exercises, startIndex: AbsIntermediateScreen.lastExerciseIndex);
                    },
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${AbsIntermediateScreen.getProgress().toStringAsFixed(0)}% completed',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
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
                    onPressed: () => _startWorkout(exercises),
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
                        fontWeight: FontWeight.bold,
                      ),
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