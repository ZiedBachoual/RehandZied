// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rehand/views/screens/doctor/add_patient.dart';
import 'package:rehand/views/screens/doctor/patient_card.dart';
import 'package:rehand/views/screens/doctor/supervised%20patients/patient_details.dart';

class HomeDoc extends StatelessWidget {
  final CollectionReference patients =
      FirebaseFirestore.instance.collection('users');
  // ignore: use_key_in_widget_constructors
  HomeDoc({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 74.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Supervised Patients",
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF724AB4),
                  ),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    _addPatient(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: Colors.deepPurple.shade200,
                    elevation: 6,
                    padding: const EdgeInsets.all(13.0),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      patients.where('role', isEqualTo: 'patient').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final data = snapshot.requireData;

                    final filteredPatients = data.docs.where((patient) {
                      var patientData = patient.data() as Map<String, dynamic>?;
                      var injuryType =
                          patientData?['injuryType'] as String? ?? 'Unknown';
                      return injuryType != 'Unknown';
                    }).toList();

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: filteredPatients.length,
                      itemBuilder: (context, index) {
                        var patient = filteredPatients[index];
                        var name = patient['username'];
                        var injuryType = 'Unknown';

                        try {
                          var patientData =
                              patient.data() as Map<String, dynamic>?;

                          if (patientData != null) {
                            injuryType = patientData['injuryType'] as String? ??
                                'Unknown';
                          } else {
                            print("Patient data is null");
                          }
                        } catch (e) {
                          print("Error accessing injuryType: $e");
                        }
                        return PatientCard(
                          name: name,
                          injuryType: injuryType,
                          avatarColor:
                              Colors.primaries[index % Colors.primaries.length],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  username: name,
                                  injuryType: injuryType,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addPatient(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPatientScreen()),
    );
  }
}
