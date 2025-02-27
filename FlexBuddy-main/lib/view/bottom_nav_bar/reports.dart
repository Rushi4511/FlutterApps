// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_buddy/controller/sessions.dart';
import 'package:flex_buddy/view/bottom_nav_bar/bmi.dart';
import 'package:flex_buddy/view/details_screen/weight_screen.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';
import 'package:intl/intl.dart';

late String? email;

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTime _selectedDate = DateTime.now();
  List<double> weightArray = [];
  double? currentWeight;
  double? lightestWeight;
  double? heaviestWeight;
  double? height;
  int? age;

  var currentWorkout = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int totalCalories = 0;
  int totalMinutes = 0;

  Future<void> collectData() async {
    await SessionData.getSessionData();
    email = SessionData.emailId;
    log("-------------On Reports Screen $email");
  }

  Future<void> getWorkoutDone(String? formattedDate) async {

    log("----------------------GET DATA WORKOUT DONE------------------");
    await collectData();
    workoutData.clear();
    totalCalories = 0;
    totalMinutes = 0;

    log("------In getworkoutdone----$formattedDate");
    QuerySnapshot response = await FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('workouts done')
        .doc(formattedDate)
        .collection(formattedDate!)
        .get();

    for (int i = 0; i < response.docs.length; i++) {
      var workoutItem = {
        'workoutName': response.docs[i]['workoutName'],
        'calories': response.docs[i]['calories'],
        'minutes': response.docs[i]['min'],
      };
      workoutData.add(workoutItem);

      // Calculate total calories and minutes
      totalCalories += int.parse(workoutItem['calories'].toString());
      totalMinutes += int.parse(workoutItem['minutes'].toString());
    }

    log("WORKOUT LEN:${workoutData.length}");
    log("Total Calories: $totalCalories");
    log("Total Minutes: $totalMinutes");
  }

  Future<void> _fetchWeightArray() async {
    try {
      await collectData();
      final doc = await _firestore.collection('Users').doc(email).get();
      if (doc.exists && doc.data()!.containsKey('weightArray')) {
        final fetchedWeights = List<double>.from(doc['weightArray']);
        log(fetchedWeights.toString());
        currentWeight = doc['weight'];
        lightestWeight = doc['lightestWeight'];
        heaviestWeight = doc['heaviestWeight'];
        height = doc['height'];
        age = doc['age'];
        setState(() {
          weightArray = fetchedWeights;
        });
        print('Weight Array: $weightArray'); // Debugging output
      } else {
        print('Weight array not found or document does not exist');
      }
    } catch (e) {
      print('Error fetching weightArray: $e');
    }
  }

  final List<Map<String, dynamic>> workoutData = [];

  Future<void> _getCurrentDayWorkout() async {
    log("---------------------GET CURRENT DAY WORKOUT--------------");
    log("SELECTED DATE:$_selectedDate");
    String dateKey = DateFormat('yyyy-MM-dd').format(_selectedDate);
    log("-----------------$dateKey");
    await getWorkoutDone(dateKey);
    log("---------------------DONE--------------");
  currentWorkout = workoutData;
  setState(() {
    
  });
    // return workoutData;
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color iconColor,
  }) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightSection() {
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
                'Weight',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WeightScreen(fromEdit: true),
                  ),
                );
                // Refresh data after returning from weight screen
                await _fetchWeightArray();
                setState(() {});
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Edit',
                  style: GoogleFonts.montserrat(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current',
                    style: GoogleFonts.montserrat(color: Colors.grey),
                  ),
                  Text(
                    currentWeight.toString(),
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Heaviest $heaviestWeight',
                    style: GoogleFonts.montserrat(color: Colors.grey),
                  ),
                  Text(
                    'Lightest $lightestWeight',
                    style: GoogleFonts.montserrat(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 100,
            child: weightArray.isEmpty
                ? Center(
                    child: Text(
                      'No data available',
                      style: GoogleFonts.montserrat(color: Colors.grey),
                    ),
                  )
                : LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: weightArray.asMap().entries.map((entry) {
                            return FlSpot(entry.key.toDouble(), entry.value);
                          }).toList(),
                          isCurved: true,
                          color: Colors.blue,
                          barWidth: 1.5,
                          dotData: const FlDotData(show: true),
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.blue.withOpacity(0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var currentWorkout = _getCurrentDayWorkout();
    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: () async{
          _fetchWeightArray();
          _getCurrentDayWorkout();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Report',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
        
                // Stats Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard(
                      icon: Icons.fitness_center,
                      value: currentWorkout.length.toString(),
                      label: 'Workout',
                      iconColor: Colors.blue,
                    ),
                    _buildStatCard(
                      icon: Icons.local_fire_department,
                      value: totalCalories.toString(),
                      label: 'Kcal',
                      iconColor: Colors.orange,
                    ),
                    _buildStatCard(
                      icon: Icons.timer,
                      value: totalMinutes.toString(),
                      label: 'Minute',
                      iconColor: Colors.purple,
                    ),
                  ],
                ),
        
                const SizedBox(height: 24),
        
                // Calendar Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'History',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: WeeklyDatePicker(
                    selectedDay: _selectedDate,
                    changeDay: (value){
                      print(value);
                      setState(() {
                        _selectedDate = value;
                        _getCurrentDayWorkout();
                      });
                    },
                    enableWeeknumberText: false,
                    backgroundColor: Colors.transparent,
                    weekdayTextColor: Colors.white,
                    selectedDigitBackgroundColor: Colors.white,
                    selectedDigitColor: Colors.black,
                    digitsColor: Colors.white,
                    weekdays: const ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
                  ),
                ),
        
                const SizedBox(height: 24),
        
                
                // Selected Day Workout Details
                if (workoutData.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Workouts on ${DateFormat('MMM d, yyyy').format(_selectedDate)}',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: workoutData.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.fitness_center,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Workout ${index + 1}',
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Exercise Name : ${workoutData[index]['workoutName']}\nCal : ${workoutData[index]['calories']} Kcal\nMins : ${workoutData[index]['minutes']} ',
                                          style: GoogleFonts.montserrat(
                                            color: Colors.grey[300],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
        
                const SizedBox(height: 24),
        
                // Weight Section
                _buildWeightSection(),
        
                const SizedBox(height: 24),
                
                // BMI Section
                BMICalculatorWidget(
                  weight: currentWeight??0,   // Example weight in kg
                  height: height??0,  // Example height in cm
                  age: 30,        // Example age
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchWeightArray();
    _getCurrentDayWorkout();
  }
}
