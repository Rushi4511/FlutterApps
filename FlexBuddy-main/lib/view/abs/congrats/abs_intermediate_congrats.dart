import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class AbsIntermediateCongratsScreen extends StatefulWidget {
  final int exercisesCompleted;
  final int totalCalories;
  final int totalMinutes;
  const AbsIntermediateCongratsScreen(
      {super.key,
      required this.exercisesCompleted,
      required this.totalCalories,
      required this.totalMinutes});

  @override
  State<AbsIntermediateCongratsScreen> createState() =>
      _AbsIntermediateCongratsScreenState();
}

class _AbsIntermediateCongratsScreenState extends State<AbsIntermediateCongratsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Scale animation
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    // Start the animation
    _animationController.forward();

    // Auto-close the screen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Trophy Image
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.network(
                    "https://img.freepik.com/free-vector/trophy_78370-345.jpg?size=626&ext=jpg",
                    height: 200,
                    width: 200,
                  ),
                ),

                const SizedBox(height: 20),

                // Congratulations Text with Gradient
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.blue.shade200, Colors.blue.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    'Congratulations!',
                    style: GoogleFonts.montserrat(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),

                const SizedBox(height: 20),

                // Workout Summary Container with Glassmorphism Effect
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.2), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 10,
                        )
                      ]),
                  child: Column(
                    children: [
                      _buildStatRow(Icons.fitness_center, 'Exercises Completed',
                          widget.exercisesCompleted.toString()),
                      const SizedBox(height: 10),
                      _buildStatRow(Icons.local_fire_department,
                          'Calories Burned', '${widget.totalCalories} cal'),
                      const SizedBox(height: 10),
                      _buildStatRow(Icons.timer, 'Total Time',
                          '${widget.totalMinutes} min'),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Motivational Text with Subtle Animation
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 1000),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, opacity, child) {
                    return Opacity(
                      opacity: opacity,
                      child: child,
                    );
                  },
                  child: Text(
                    'Keep pushing! You\'re getting stronger.',
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blue, size: 30),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style:
                    GoogleFonts.montserrat(color: Colors.white70, fontSize: 14),
              ),
              Text(
                value,
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    );
  }
}
