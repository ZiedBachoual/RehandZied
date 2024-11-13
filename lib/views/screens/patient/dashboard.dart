import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rehand/views/widgets/info_card.dart';

class Dash extends StatefulWidget {
  const Dash({super.key});

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
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

  String calculateTotalUsage() {
    int totalseconds = (done1 ? 30 : 0) + (done2 ? 30 : 0);
    return '$totalseconds seconds'; // Example result
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(35.0),
              child: Text(
                "Track your progress!",
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8068A6),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              // Expanded to fill the remaining space
              child: Container(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to full screen width
                decoration: const BoxDecoration(
                  color: Color(0xFF8068A6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InfoCard(
                              title: 'Practice Time',
                              value: calculateTotalUsage()),
                          const SizedBox(height: 40),
                          InfoCard(
                              title: 'Exercises Achieved',
                              value: numberOfExercises().toString()),
                        ],
                      ),
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
