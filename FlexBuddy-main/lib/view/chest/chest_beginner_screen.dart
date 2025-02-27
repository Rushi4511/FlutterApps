import 'package:flex_buddy/exercise_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Model class for Exercise
class ChestBeginnerModel {
  final String name;
  final String count;
  final String imagePath;

  ChestBeginnerModel({
    required this.name,
    required this.count,
    required this.imagePath,
  });
}

class ChestBeginnerScreen extends StatelessWidget {
  const ChestBeginnerScreen({super.key});

  final bool exerciseStarted = false;
  @override
  Widget build(BuildContext context) {
    // List of exercises
    final List<ChestBeginnerModel> exercises = [
      ChestBeginnerModel(
        name: 'Jumping Jacks',
        count: '00:30',
        imagePath: 'assets/images/exercise_gif/jumping_jacks.gif',
      ),
      ChestBeginnerModel(
        name: 'Incline Push-Ups',
        count: '×10',
        imagePath: 'assets/images/exercise_gif/Incline_push_up.gif',
      ),
      ChestBeginnerModel(
        name: 'Push-Ups',
        count: '×8',
        imagePath: 'assets/images/exercise_gif/Push_ups.gif',
      ),
      ChestBeginnerModel(
        name: 'Wide Arm Push-Ups',
        count: '×8',
        imagePath: 'assets/images/exercise_gif/Widearm_push_ups.gif',
      ),
      ChestBeginnerModel(
        name: 'Tricep Dips',
        count: '×10',
        imagePath: 'assets/images/exercise_gif/Triceps_dips.gif',
      ),
      ChestBeginnerModel(
        name: 'Wide Arm Push-Ups',
        count: '×6',
        imagePath: 'assets/images/exercise_gif/Widearm_push_ups.gif',
      ),
      ChestBeginnerModel(
        name: 'Incline Push-Ups',
        count: '×10',
        imagePath: 'assets/images/exercise_gif/Incline_push_up.gif',
      ),
      ChestBeginnerModel(
        name: 'Tricep Dips',
        count: '×10',
        imagePath: 'assets/images/exercise_gif/Triceps_dips.gif',
      ),
      ChestBeginnerModel(
        name: 'Knee Push-Ups',
        count: '×8',
        imagePath: 'assets/images/exercise_gif/Knee_push_ups.gif',
      ),
      ChestBeginnerModel(
        name: 'Cobra Stretch',
        count: '00:20',
        imagePath: 'assets/images/exercise_gif/cobra_stretch.gif',
      ),
      ChestBeginnerModel(
        name: 'Chest Stretch',
        count: '00:20',
        imagePath: 'assets/images/exercise_gif/Chest_stretch.gif',
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
                'CHEST BEGINNER',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: Image.asset(
                'assets/images/chest.jpg',
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
                    '9 mins • 11 Workouts',
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
