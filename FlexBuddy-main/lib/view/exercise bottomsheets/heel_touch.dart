import 'package:flutter/material.dart';

class HeelTouch extends StatelessWidget {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black12,
      builder: (context) => const Material(
        type: MaterialType.transparency,
        child: HeelTouch(),
      ),
    );
  }

  const HeelTouch({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure we have Material ancestor for the bottom sheet content
    return Material(
      type: MaterialType.transparency,
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                // Handle bar for dragging
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Title bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'HEEL TOUCH',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                // Main content
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/exercise_gif/heel_touch.gif',
                            height: 320,
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          ),
                          // const SizedBox(height: 24),

                          // Rest of the content remains the same...
                          // (Previous sections for Instructions, Focus Area, Common Mistakes, and Breathing Tips)
                          // Tab Bar
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Instructions Section
                          Text(
                            'INSTRUCTIONS',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Start with your feet together and your arms by your sides, then jump up with your feet apart and your hands overhead.',
                            style: TextStyle(
                                fontSize: 16, height: 1.5, color: Colors.white),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Return to the start position then do the next rep. This exercise provides a full-body workout and works all your large muscle groups.',
                            style: TextStyle(
                                fontSize: 16, height: 1.5, color: Colors.white),
                          ),
                          const SizedBox(height: 24),

                          // Focus Area Section
                          Text(
                            'FOCUS AREA',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            children: [
                              _buildFocusChip('Abs', true),
                            ],
                          ),
                          const SizedBox(height: 24),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "assets/images/exercise_body/Body4.jpg",
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'COMMON MISTAKES',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Mistake 1
                              _buildMistakeItem(
                                number: '1',
                                title: 'Landing too hard',
                                description:
                                    'When you jump in the air and come down, '
                                    'you are putting too much impact or pressure '
                                    'on your feet, ankles, knees or other joints, '
                                    'this can lead to discomfort or injury. Try to '
                                    'land on the balls of your feet rather than '
                                    'your heels. It absorbs more shock.',
                              ),

                              // Mistake 2
                              _buildMistakeItem(
                                number: '2',
                                title: 'Not keeping the knees bent',
                                description:
                                    'Failing to keep the knees bent can cause the '
                                    'exercise to be less effective.',
                              ),

                              // Mistake 3
                              _buildMistakeItem(
                                number: '3',
                                title: 'Not engaging the core',
                                description:
                                    'It requires the core muscles to be engaged '
                                    'throughout the entire exercise. If the core is '
                                    'not engaged, it can lead to poor form and an '
                                    'ineffective workout.',
                              ),
                              const SizedBox(height: 24),

                              const Text(
                                'BREATHING TIPS',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Breathing Tips List
                              _buildBreathingTip(
                                  'Inhale as you jump your feet apart.'),
                              _buildBreathingTip(
                                  'exhale as you jump your feet back together.'),
                              _buildBreathingTip(
                                  'Take deep breaths to fully oxygenate your body.'),
                              const SizedBox(height: 32),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  'CLOSE',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper methods remain the same...
  Widget _buildFocusChip(String label, bool isPrimary) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: isPrimary ? Colors.blue[700] : Colors.blue[300],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildMistakeItem({
    required String number,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreathingTip(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(
                  fontSize: 16, height: 1.5, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
