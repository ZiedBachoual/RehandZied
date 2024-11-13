import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

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
              const Padding(
                padding: EdgeInsets.only(top: 140.0),
                child: Text(
                  "Hello Sunshine !",
                  style: TextStyle(
                    fontSize: 38.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF724AB4),
                  ),
                ),
              ),
              const SizedBox(height: 90.0),
              Container(
                height: 135.0,
                width: 318.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EDE6), // Or any desired color
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 23),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/displayDoctors');
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.chat_outlined,
                          color: Color(0xFF724AB4),
                          size: 35,
                        ),
                        SizedBox(width: 17.0),
                        Text(
                          "Talk to\n your Doctor",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35.0),
              Container(
                height: 135.0,
                width: 318.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EDE6), // Or any desired color
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 23),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/AI');
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.chat_outlined,
                          color: Color(0xFF724AB4),
                          size: 35,
                        ),
                        SizedBox(width: 17.0),
                        Text(
                          "Talk to\nAI Assistant",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
