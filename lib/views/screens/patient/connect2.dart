import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehand/views/widgets/round_button.dart';

class Connect2 extends StatelessWidget {
  const Connect2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBFB0D1),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 67),
              Image.asset(
                "assets/gant.png",
                width: 115,
                height: 115,
              ),
              const SizedBox(height: 25),
              const Text(
                'Connect the Glove',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF724AB4),
                ),
              ),
              const Text(
                'to your Phone !',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF724AB4),
                ),
              ),
              const SizedBox(height: 19),
              const Text(
                'Make sure to follow these steps',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF724AB4),
                ),
              ),
              const SizedBox(height: 45.0),
              Container(
                height: 59.0,
                width: 330.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFDED7D1), // Or any desired color
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                ),
                child: const Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Row(
                    children: [
                      // Add your icon widget here
                      Icon(
                        Icons.task_alt, // Replace with your desired icon
                        color: Color(0xFF724AB4),
                      ),
                      SizedBox(width: 10.0), //spacing between icon and text
                      Text(
                        "Turn on the Glove",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 21.0),
              Container(
                height: 59.0,
                width: 330.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFDED7D1), // Or any desired color
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                ),
                child: const Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Row(
                    children: [
                      // Add your icon widget here
                      Icon(
                        Icons.task_alt, // Replace with your desired icon
                        color: Color(0xFF724AB4),
                      ),
                      SizedBox(
                          width:
                              10.0), // Add some spacing between icon and text
                      Text(
                        "Make sure your wifi is stable",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 21.0),
              Container(
                height: 59.0,
                width: 330.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFDED7D1), // Or any desired color
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                ),
                child: const Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Row(
                    children: [
                      // Add your icon widget here
                      Icon(
                        Icons.task_alt, // Replace with your desired icon
                        color: Color(0xFF724AB4),
                      ),
                      SizedBox(
                          width:
                              10.0), // Add some spacing between icon and text
                      Text(
                        "Make sure the glove is charged",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 43.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Login Button Row
                  RoundButton(
                    onPressed: () {
                      Get.toNamed('/Exercise2');
                    },
                    buttonText: '  Connect',
                    hasIcon: false,
                  ),

                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Functionality for Create Account text
                          Get.toNamed('/Exercise2');
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF724AB4),
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
      ),
    );
  }
}
