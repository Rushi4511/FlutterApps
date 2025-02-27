import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BMICalculatorWidget extends StatefulWidget {
  final double weight;
  final double height;
  final int age;

  const BMICalculatorWidget({
    super.key, 
    required this.weight, 
    required this.height, 
    required this.age
  });

  @override
  State createState() => _BMICalculatorWidgetState();
}

class _BMICalculatorWidgetState extends State<BMICalculatorWidget> {
  // Calculate BMI
  double calculateBMI() {
    // BMI Formula: weight (kg) / (height (m))^2
    return widget.weight / (widget.height / 100 * widget.height / 100);
  }

  // Determine BMI Category
  String getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal Weight';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  // Get Color for BMI Category
  Color getBMICategoryColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final bmi = calculateBMI();
    final bmiCategory = getBMICategory(bmi);
    final categoryColor = getBMICategoryColor(bmi);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BMI Calculator',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // BMI Value
          Text(
            bmi.toStringAsFixed(1),
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          // BMI Category
          Text(
            bmiCategory,
            style: GoogleFonts.montserrat(
              color: categoryColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // BMI Gradient Indicator
          Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: const LinearGradient(
                colors: [
                  Colors.blue,    // Underweight
                  Colors.green,   // Normal Weight
                  Colors.yellow,  // Overweight start
                  Colors.orange,  // Overweight end
                  Colors.red,     // Obese
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Details Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Height',
                style: GoogleFonts.montserrat(color: Colors.grey),
              ),
              Text(
                "${widget.height.toStringAsFixed(1)} CM",
                style: GoogleFonts.montserrat(color: Colors.white),
              ),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Weight',
                style: GoogleFonts.montserrat(color: Colors.grey),
              ),
              Text(
                "${widget.weight.toStringAsFixed(1)} KG",
                style: GoogleFonts.montserrat(color: Colors.white),
              ),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Age',
                style: GoogleFonts.montserrat(color: Colors.grey),
              ),
              Text(
                "${widget.age} Years",
                style: GoogleFonts.montserrat(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}