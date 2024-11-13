import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rehand/views/widgets/info_card.dart';

class DetailPage extends StatefulWidget {
  final String username;
  final String injuryType;

  const DetailPage({
    super.key,
    required this.username,
    required this.injuryType,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Dashboard",
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8068A6),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 65.0, top: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor:
                                Colors.primaries[2 % Colors.primaries.length],
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          const SizedBox(width: 18),
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start, // Align text to start
                            children: [
                              Text(
                                widget.username,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Injury Type:\n${widget.injuryType}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 34.0),
                    Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(height: 40),
                          InfoCard(
                            title: 'Practice Time',
                            value: calculateTotalUsage(),
                            color: const Color(0xFF8068A6),
                          ),
                          const SizedBox(height: 40),
                          InfoCard(
                            title: 'Exercises Achieved',
                            value: numberOfExercises().toString(),
                            color: const Color(0xFF8068A6),
                          ),
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
