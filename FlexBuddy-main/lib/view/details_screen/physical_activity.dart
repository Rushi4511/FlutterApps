import 'package:flex_buddy/view/details_screen/age_screen.dart';
import 'package:flex_buddy/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhysicalActivityScreen extends StatefulWidget {
  const PhysicalActivityScreen({super.key});

  @override
  State<PhysicalActivityScreen> createState() => _PhysicalActivityScreenState();
}

class _PhysicalActivityScreenState extends State<PhysicalActivityScreen> {
  String? selectedGoal;

  final List<Map<String, dynamic>> activityLevels = [
    {
      'title': 'Beginner',
      'description': 'New to fitness or returning after a long break',
      'icon': Icons.accessibility_new,
    },
    {
      'title': 'Intermediate',
      'description': 'Regular exercise with moderate intensity',
      'icon': Icons.fitness_center,
    },
    {
      'title': 'Advanced',
      'description': 'Experienced with high-intensity workouts',
      'icon': Icons.sports_martial_arts,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  _buildTitle(),
                  const SizedBox(height: 20),
                  _buildSubtitle(),
                  const SizedBox(height: 40),
                  _buildActivityOptions(),
                  const SizedBox(height: 85),
                  _buildContinueButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "Physical Activity Level",
      style: GoogleFonts.montserrat(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        height: 1.2,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      "Select your experience level to get a personalized workout plan",
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
        fontSize: 16,
        color: Colors.white70,
        height: 1.5,
      ),
    );
  }

  Widget _buildActivityOptions() {
    return Column(
      children: activityLevels.map((level) => _buildGoalOption(level)).toList(),
    );
  }

  Widget _buildGoalOption(Map<String, dynamic> level) {
    final isSelected = selectedGoal == level['title'];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGoal = level['title'];
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected
                ? [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.1),
                  ]
                : [
                    Colors.white.withOpacity(0.05),
                    Colors.white.withOpacity(0.05),
                  ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.3),
            width: isSelected ? 2.5 : 1,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                level['icon'],
                color: isSelected ? MyColors.yellow : Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    level['title'],
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    level['description'],
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? MyColors.yellow
                      : Colors.white.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Icon(
                        Icons.check,
                        size: 20,
                        color: MyColors.yellow,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: 300,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Colors.white24,
          Colors.white24,
        ]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: selectedGoal != null
            ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AgeScreen(),
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          "Continue",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: selectedGoal != null ? MyColors.yellow : Colors.white,
          ),
        ),
      ),
    );
  }
}
