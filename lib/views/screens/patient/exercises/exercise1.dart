// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:firebase_database/firebase_database.dart';

class Exercise1 extends StatefulWidget {
  const Exercise1({super.key});

  @override
  State<Exercise1> createState() => _Exercise1State();
}

class _Exercise1State extends State<Exercise1> {
  final rtdb = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          'https://rehand-6f638-default-rtdb.europe-west1.firebasedatabase.app/');
  late DatabaseReference ref;

  bool done1 = false;
  int ex1 = 0;
  double flexData = 0.0;
  bool isFetching = false;
  Timer? _timer;
  int timeLeft = 30;
  double f = 0.0;

  @override
  void initState() {
    super.initState();
    _readData();
    ref = rtdb.ref("variables/");
  }

  // Method to start the countdown timer and fetch data
  void _startCountDown() {
    _timer?.cancel();
    setState(() {
      timeLeft = 30;
      isFetching = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          isFetching = false;
          timer.cancel();
          setState(() {
            ex1 = 0;
            done1 = true; // Reset ex1 to 0 when the timer ends
          });
          _saveEx1ToRTDB(ex1, done1);

          Future.delayed(
            const Duration(seconds: 2),
            () {
              Get.toNamed('/mainPat');
            },
          );
          // Save ex1 to Realtime Database after timer ends
        }
      });
    });
  }

  // Method to save ex1 variable to Firestore
  void _saveEx1ToRTDB(int value, bool value1) async {
    await ref.update({
      "ex1": value,
      "ex2": 0,
      "done1": value1,
    }).then((_) {
      print('Data saved successfully');
    }).catchError((error) {
      print('Failed to save data: $error');
    });
  }

  void _readData() {
    rtdb.ref('sensor3/flex').onValue.listen((event) {
      setState(() {
        flexData = double.parse(
            event.snapshot.value.toString()); // Parse flex data to double
      });
    });
  }

  flexValues() {
    if (flexData == 1.0) {
      f = 100.0;
    } else if (flexData == 0.0) {
      f = 0.0;
    }
    return f;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.toNamed('/mainPat');
            setState(() {
              ex1 = 0;
              done1 = false; // Reset ex1 to 0 when the timer ends
            });
            _saveEx1ToRTDB(ex1, done1);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Exercise 1",
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade400,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Start with the fingers extended straight out. Make a hook fist, return to a straight hand. Make a full fist, return to a straight hand. Make a straight fist, return to a straight hand.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Text(
              timeLeft == 0 ? 'D O N E' : timeLeft.toString(),
              style: const TextStyle(fontSize: 35),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _startCountDown();
                setState(() {
                  ex1 = 1;
                  done1 = true;
                });
                _saveEx1ToRTDB(ex1, done1);
              },
              style: ElevatedButton.styleFrom(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'S T A R T',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              width: 350,
              height: 400,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: SemicircularIndicator(
                        radius: 100,
                        color: Colors.yellow,
                        backgroundColor: Colors.orange,
                        strokeWidth: 13,
                        bottomPadding: 0,
                        progress: flexValues() / 100,
                        child: Text(
                          '${(flexValues() / 100 * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      "assets/hand_pics/flex_ex.png",
                      width: 300,
                      height: 200,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
