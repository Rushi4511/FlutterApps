import 'package:flex_buddy/view/details_screen/physical_activity.dart';
import 'package:flex_buddy/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  String? selectedGoal;

  final List<Map<String, dynamic>> goals = [
    {
      'title': 'Lose Weight',
      'description': 'Reduce body fat and achieve a healthier weight',
      'icon': Icons.trending_down,
    },
    {
      'title': 'Gain Weight',
      'description': 'Build healthy mass and increase body weight',
      'icon': Icons.trending_up,
    },
    {
      'title': 'Muscle Mass Gain',
      'description': 'Build strength and increase muscle definition',
      'icon': Icons.fitness_center,
    },
    {
      'title': 'Shape Body',
      'description': 'Tone muscles and improve overall physique',
      'icon': Icons.accessibility_new,
    },
    {
      'title': 'Others',
      'description': 'Custom fitness goals and objectives',
      'icon': Icons.more_horiz,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                _buildTitle(),
                const SizedBox(height: 25),
                _buildGoalOptions(),
                const SizedBox(height: 15),
                _buildContinueButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "What Is Your Goal?",
      style: GoogleFonts.montserrat(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        height: 1.2,
      ),
    );
  }


  Widget _buildGoalOptions() {
    return Column(
      children: goals.map((goal) => _buildGoalOption(goal)).toList(),
    );
  }

  Widget _buildGoalOption(Map<String, dynamic> goal) {
    final isSelected = selectedGoal == goal['title'];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGoal = goal['title'];
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
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
                goal['icon'],
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
                    goal['title'],
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    goal['description'],
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
                  color: isSelected ? MyColors.yellow : Colors.white.withOpacity(0.5),
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
        gradient: const LinearGradient(
          colors: [
            Colors.white24,
            Colors.white24,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: selectedGoal != null
            ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PhysicalActivityScreen(),
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