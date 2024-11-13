import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehand/views/widgets/round_button.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4F0), // Background color
      body: Center(
        child: Column(
          //texts
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Ready for your healing journey?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF8067A9),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 19.0),
            const Text(
              'Let\'s get started!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 36,
                  color: Color(0xFF8067A9),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
                height: 62.0), // Add spacing between texts and buttons
            // Row for Login and Create Account buttons
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Login Button Row
                RoundButton(
                  onPressed: () {
                    Get.toNamed('/login');
                  },
                  buttonText: 'LogIn',
                  hasIcon: true,
                  icon: const Icon(Icons.login_outlined,
                      size: 30.0, color: Colors.white),
                ),

                const SizedBox(height: 34.0),
                // Create Account Button Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Functionality for Create Account text
                        Get.toNamed('/createAccount');
                      },
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8067A9),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
