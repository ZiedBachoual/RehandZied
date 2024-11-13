import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehand/views/widgets/custom_button.dart';

class ChooseGoal extends StatefulWidget {
  const ChooseGoal({super.key});

  @override
  State<ChooseGoal> createState() => _ChooseGoalState();
}

class _ChooseGoalState extends State<ChooseGoal> {
  String selectedGoal = 'None selected';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Top container with centered text
          Column(
            children: [
              Container(
                color: const Color(0xFF8068A6),
                height: MediaQuery.of(context).size.height / 3,
                child: const Center(
                  child: Column(
                    // Stack text elements vertically
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Center vertically within the column
                    children: [
                      Text(
                        'We want to',
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF5F4F0),
                        ),
                      ),
                      Text(
                        'know you better!', // Add your second text here
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF5F4F0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom container with rounded corners
          Positioned(
            top: MediaQuery.of(context).size.height / 3.5,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 32.0),
                    const Text(
                      'Let\'s set your goal',
                      style: TextStyle(
                        fontSize: 29.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8067A9),
                      ),
                    ),
                    const SizedBox(height: 110.0),

                    // Your radio button code here
                    SizedBox(
                      width: 365,
                      child: RadioMenuButton<String>(
                        value: 'hand',
                        groupValue: selectedGoal,
                        onChanged: (selectedValue) {
                          setState(() => selectedGoal = selectedValue!);
                        },
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          elevation: const MaterialStatePropertyAll(2),
                          backgroundColor: const MaterialStatePropertyAll(
                            Color(0xFFDED7D1),
                          ),
                        ),
                        child: const Text(
                          'I want to improve my hand movements',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: 365,
                      child: RadioMenuButton<String>(
                        value: 'wrist',
                        groupValue: selectedGoal,
                        onChanged: (selectedValue) {
                          setState(() => selectedGoal = selectedValue!);
                        },
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          elevation: const MaterialStatePropertyAll(2),
                          backgroundColor: const MaterialStatePropertyAll(
                            Color(0xFFDED7D1),
                          ),
                        ),
                        child: const Text(
                          'I want to improve my wrist control',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: 365,
                      child: RadioMenuButton<String>(
                        value: 'fingers',
                        groupValue: selectedGoal,
                        onChanged: (selectedValue) {
                          setState(() => selectedGoal = selectedValue!);
                        },
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          elevation: const MaterialStatePropertyAll(2),
                          backgroundColor: const MaterialStatePropertyAll(
                            Color(0xFFDED7D1),
                          ),
                        ),
                        child: const Text(
                          'I want to improve my fingers control',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 110.0),
                    CustomButton(
                      onPressed: () {
                        Get.toNamed('/connectGlove');
                      },
                      buttonText: 'Next',
                    ),

                    /*
            if (selectedGoal == 'hand') [
              // Display information and exercises for hand
            ] else if (selectedGoal == 'wrist') [
              // Display information and exercises for wrist
            ] else if (selectedGoal == 'fingers') [
              // Display information and exercises for fingers
            ]else[
              showToast(message: 'Please choose a goal');
            ],*/
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
