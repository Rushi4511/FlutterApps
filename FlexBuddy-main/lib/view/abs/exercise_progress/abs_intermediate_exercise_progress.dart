import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_buddy/view/abs/abs_intermediate_screen.dart';
import 'package:flex_buddy/controller/sessions.dart';
import 'package:flex_buddy/view/abs/congrats/abs_intermediate_congrats.dart';
import 'package:flex_buddy/view/abs/database/abs_beginner_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:intl/intl.dart';

class AbsIntermediateExerciseProgressScreen extends StatefulWidget {
  final List<AbsIntermediateModel> exercises;
  final int startIndex;

  const AbsIntermediateExerciseProgressScreen({
    super.key, 
    required this.exercises,
    this.startIndex = 0,
  });

  @override
  State<AbsIntermediateExerciseProgressScreen> createState() => _AbsBeginnerExerciseProgressScreenState();
}

class _AbsBeginnerExerciseProgressScreenState extends State<AbsIntermediateExerciseProgressScreen> {
  late int currentExerciseIndex;
  Timer? exerciseTimer;
  int remainingSeconds = 0;
  bool isPaused = false;
  bool isResting = false;
  int restSeconds = 3;
  late String? email;

  Future<void> collectData() async {
    await SessionData.getSessionData();
    email = SessionData.emailId;
    log("-------------On Exercise Screen $email");

  }
  @override
  void initState() {
    super.initState();
    currentExerciseIndex = widget.startIndex;
    AbsIntermediateScreen.exerciseStarted = true;
    collectData();
    LocalDatabase.saveWorkoutProgress(
      tableName: 'AbsIntermediate',
      isStarted: true,
      currentIndex: currentExerciseIndex,
      progress: (currentExerciseIndex+1) / widget.exercises.length *100
    );
    setupExercise();
  }

  void setupExercise() {
    if (currentExerciseIndex >= widget.exercises.length) {
      // Workout completed
      AbsIntermediateScreen.exerciseStarted = false;
      Navigator.pop(context);
      return;
    }

    final exercise = widget.exercises[currentExerciseIndex];
    if (exercise.count.startsWith('00:')) {
      // This is a timed exercise
      remainingSeconds = int.parse(exercise.count.substring(3));
      startTimer(onComplete: () {
        if (currentExerciseIndex < widget.exercises.length - 1) {
          startRest();
        } else {
          completeWorkout();
        }
      });
    } else {
      // This is a rep-based exercise
      remainingSeconds = 0;
    }
  }

  void startTimer({required Function onComplete}) {
    exerciseTimer?.cancel();
    exerciseTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
        onComplete();
      }
    });
  }

  void startRest() {
    setState(() {
      isResting = true;
      remainingSeconds = restSeconds;
    });
    startTimer(onComplete: () {
      setState(() {
        isResting = false;
        currentExerciseIndex++;
      });
      setupExercise();
    });
  }

  void nextExercise() {
    exerciseTimer?.cancel();
    if (currentExerciseIndex < widget.exercises.length - 1) {
      LocalDatabase.saveWorkoutProgress(
        tableName: 'AbsIntermediate',
        isStarted: true,
        currentIndex: currentExerciseIndex,
        progress: (currentExerciseIndex+1) / widget.exercises.length * 100
      );
      startRest();
    } else {
      completeWorkout();
    }
  }

  void completeWorkout() async {
    AbsIntermediateScreen.exerciseStarted = false;
    AbsIntermediateScreen.lastExerciseIndex = 0;
    
    LocalDatabase.resetWorkoutProgress(tableName: 'AbsIntermediate',);

    // Save workout to Firestore
  if (email != null) {
    final now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    // String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    try {
      final workoutData = {
        'workoutName': 'Abs Intermediate', // Customize based on workout
        'timestamp': now,
        'exercisesCompleted': widget.exercises.length,
        'calories': 110,
        'min': 32,
      };

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(email)
          .collection('workouts done')
          .doc(formattedDate).collection(formattedDate).doc(now.toString())
          .set(workoutData);

      log("Workout saved successfully for $email on $formattedDate");
    } catch (e) {
      log("Error saving workout: $e");
    }
  } else {
    log("Email not found; unable to save workout.");
  }

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AbsIntermediateCongratsScreen(exercisesCompleted: 14, totalCalories: 110, totalMinutes: 32))
    );
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
      if (isPaused) {
        exerciseTimer?.cancel();
      } else {
        if (isResting) {
          startTimer(onComplete: () {
            setState(() {
              isResting = false;
              currentExerciseIndex++;
            });
            setupExercise();
          });
        } else {
          startTimer(onComplete: () {
            if (currentExerciseIndex < widget.exercises.length - 1) {
              startRest();
            } else {
              completeWorkout();
            }
          });
        }
      }
    });
  }

  Future<bool> _handlePopScope() async {
    // Save progress when back button is pressed
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Exit Workout?',
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
        content: Text(
          'Your progress will be saved',
          style: GoogleFonts.montserrat(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'CONTINUE WORKOUT',
              style: GoogleFonts.montserrat(color: Colors.blue),
            ),
          ),
          TextButton(
            onPressed: () {
              LocalDatabase.saveWorkoutProgress(
                tableName: 'AbsIntermediate',
                isStarted: true,
                currentIndex: currentExerciseIndex,
                progress: (currentExerciseIndex+1) / widget.exercises.length * 100
              );

              AbsIntermediateScreen.lastExerciseIndex = currentExerciseIndex;
              
              Navigator.of(context).pop(true);
            },
            child: Text(
              'EXIT',
              style: GoogleFonts.montserrat(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
    return shouldPop ?? false;
  }

  @override
  void dispose() {
    exerciseTimer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    return '${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercises[currentExerciseIndex];
    final progress = (currentExerciseIndex + 1) / widget.exercises.length * 100;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final shouldPop = await _handlePopScope();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.close,color: Colors.white,),
            onPressed: () async {
              final shouldPop = await _handlePopScope();
              if (shouldPop && context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isResting ? 'REST' : exercise.name,
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              const SizedBox(height: 5,),
              Text(
                '${currentExerciseIndex + 1}/${widget.exercises.length}',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10,),
            LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.grey[800],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isResting) Image.asset(
                    exercise.imagePath,
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 32),
                  if (isResting) ...[
                    const Icon(
                      Icons.timer_outlined,
                      size: 50,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'REST TIME',
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Next: ${widget.exercises[currentExerciseIndex + 1].name}',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  if (remainingSeconds > 0)
                    Text(
                      formatTime(remainingSeconds),
                      style: GoogleFonts.montserrat(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  else if (!isResting)
                    Text(
                      exercise.count,
                      style: GoogleFonts.montserrat(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (remainingSeconds > 0)
                    FloatingActionButton(
                      onPressed: togglePause,
                      backgroundColor: Colors.blue,
                      child: Icon(isPaused ? Icons.play_arrow : Icons.pause),
                    ),
                  if (!isResting)
                    FloatingActionButton(
                      onPressed: nextExercise,
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.skip_next),
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