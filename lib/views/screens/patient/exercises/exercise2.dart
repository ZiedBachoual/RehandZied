// ignore_for_file: avoid_print

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';

class Exercise2 extends StatefulWidget {
  const Exercise2({super.key});

  @override
  State<Exercise2> createState() => _Exercise2State();
}

class _Exercise2State extends State<Exercise2> {
  final rtdb = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          'https://rehand-6f638-default-rtdb.europe-west1.firebasedatabase.app/');
  late DatabaseReference ref;

  int ex2 = 0;
  bool done2 = false;
  double percentage = 0.0;
  bool isFetching = false;
  Timer? _timer;
  int timeLeft = 30;
  late double f = 0.0;
  late double x = 0.0, y, z;
  //= 0.0, y = 0.0, z = 0.0;

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
            ex2 = 0; // Reset ex2 to 0 when the timer ends
            done2 = true; // Reset ex1 to 0 when the timer ends
          });
          _saveEx2ToRTDB(ex2, done2);

          Future.delayed(
            const Duration(seconds: 2),
            () {
              Get.toNamed('/mainPat');
            },
          ); // Save ex2 to Firestore when the timer ends
        }
      });
    });
  }

  // Method to save ex2 variable to Firestore
  // Method to save ex1 variable to Firestore
  void _saveEx2ToRTDB(int value, bool value2) async {
    await ref.update({
      "ex2": value,
      "ex1": 0,
      "done2": value2,
    }).then((_) {
      print('Data saved successfully');
    }).catchError((error) {
      print('Failed to save data: $error');
    });
  }

  void _readData() {
    rtdb.ref('sensor3/acceleration/x').onValue.listen((event) {
      setState(() {
        x = double.parse(
            event.snapshot.value.toString()); // Parse flex data to double
      });

      rtdb.ref('sensor3/acceleration/y').onValue.listen((event) {
        setState(() {
          y = double.parse(
              event.snapshot.value.toString()); // Parse flex data to double
        });
      });

      rtdb.ref('sensor3/acceleration/z').onValue.listen((event) {
        setState(() {
          z = double.parse(
              event.snapshot.value.toString()); // Parse flex data to double
        });
      });
    });
  }

  mpuValues() {
    for (x = 7; x <= 10; x++) {
      f = 100.0;
    }

    /*if ((x >= 8.1)) {
      f = 100.0;
    } else if ((x == 9.1)) {
      f = 9.0;
    }*/
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
              ex2 = 0;
              done2 = false; // Reset ex2 to 0 when the timer ends
            });
            _saveEx2ToRTDB(
                ex2, done2); // Save ex2 to Firestore when the timer ends
          },
        ),
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Exercise 2",
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
                    'Support your forearm on a table on a rolled-up towel for padding or on your knee, thumb facing upward. Move the wrist up and down through its full range of motion, as if you are waving.',
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
                  ex2 = 1;
                  done2 = true;
                });
                _saveEx2ToRTDB(ex2, done2);
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
                        progress: mpuValues() / 100,
                        bottomPadding: 0,
                        child: Text(
                          '${mpuValues().toStringAsFixed(0)}%',
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Colors.orange),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      "assets/hand_pics/ex2.png",
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
