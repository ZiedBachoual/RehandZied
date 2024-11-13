import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:rehand/views/widgets/mission_button.dart';

class HomePat extends StatefulWidget {
  const HomePat({super.key});

  @override
  State<HomePat> createState() => _HomePatState();
}

class _HomePatState extends State<HomePat> {
  final rtdb = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          'https://rehand-6f638-default-rtdb.europe-west1.firebasedatabase.app/');
  late DatabaseReference ref;

  bool done1 = false;
  bool done2 = false;
  int nbr = 0;

  @override
  void initState() {
    super.initState();
    _readData();
  }

  void _readData() {
    rtdb.ref('variables/done1').onValue.listen((event) {
      setState(() {
        done1 = event.snapshot.value as bool;
      });
    });

    rtdb.ref('variables/done2').onValue.listen((event) {
      setState(() {
        done2 = event.snapshot.value as bool;
      });
    });
  }

  int numberOfExercises() {
    int nbr = (done1 ? 1 : 0) + (done2 ? 1 : 0);
    return nbr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 68.0,
            left: 36.0,
            right: 36.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Stay strong",
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8068A6),
                ),
              ),
              const Text(
                "Don't give up!",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8068A6),
                ),
              ),
              const SizedBox(height: 23),
              Text(
                "Missions done today: ${numberOfExercises()}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF724AB4),
                ),
              ),
              const SizedBox(height: 19),
              Center(
                child: Column(
                  children: [
                    LinearPercentIndicator(
                      width: 315.0,
                      lineHeight: 12.0,
                      percent: (numberOfExercises().toDouble() / 2),
                      backgroundColor: Colors.grey.shade300,
                      progressColor: const Color(0xFF724AB4),
                      animation: true,
                      animationDuration: 500,
                      barRadius: const Radius.circular(20),
                    ),
                    const SizedBox(
                      height: 53,
                    ),
                    Wrap(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MissionButton(
                                missionTitle: "Exercise 1",
                                missionDescription:
                                    "Fingers Flexion and Extension",
                                onTap: () {
                                  Get.toNamed('/goal');
                                }),
                            const SizedBox(height: 13),
                            MissionButton(
                                missionTitle: "Exercise 2",
                                missionDescription:
                                    "Wrist Flexion and Extension",
                                onTap: () {
                                  Get.toNamed('/goal2');
                                }),
                            /*const SizedBox(height: 13),
                            MissionButton(
                              missionTitle: "Exercise 4",
                              missionDescription: "Full Hand training",
                              onTap: () => Get.toNamed('/Exercise1'),
                            ),
                            const SizedBox(height: 13),*/
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
