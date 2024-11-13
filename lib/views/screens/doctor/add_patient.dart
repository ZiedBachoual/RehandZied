import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../controller/validators.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/get_back.dart';
// Import HomeDoc screen

class AddPatientScreen extends StatelessWidget {
  AddPatientScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _injuryTypeController = TextEditingController();

  Future<void> _addPatient(BuildContext context) async {
    final name = _nameController.text.trim();
    final injuryType = _injuryTypeController.text.trim();

    if (name.isNotEmpty && injuryType.isNotEmpty) {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: name)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot userSnapshot = querySnapshot.docs.first;
        final userId = userSnapshot.id;

        await userSnapshot.reference.update({'injuryType': injuryType});

        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          final doctorId = currentUser.uid;
          await FirebaseFirestore.instance
              .collection('doctors')
              .doc(doctorId)
              .update({
            'supervised.$userId': {'name': name, 'injuryType': injuryType}
          });

          // Refresh the HomeDoc screen
          // ignore: use_build_context_synchronously
          Navigator.popAndPushNamed(context, '/mainDoc');
        }
      } else {
        Get.snackbar('Error', 'User not found',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar('Error', 'Both fields are required',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFBFB0D1),
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 110.0),
              child: Column(
                children: [
                  buildHeaderText('Add Your Patient'),
                  buildHeaderText('to the List!'),
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: 290.0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
              child: Container(
                color: const Color(0xFFF5F4F0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 33.0),
                      const Text(
                        'Patient\'s name:',
                        style: TextStyle(
                          fontSize: 31.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8067A9),
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      SizedBox(
                        width: 340,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              decoration: inputDecoration.copyWith(
                                hintText: 'User name',
                              ),
                              validator:
                                  validateName, // Use TextFormField's built-in validator
                              controller: _nameController,
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _injuryTypeController,
                              decoration: inputDecoration.copyWith(
                                hintText: 'Injury Type',
                              ),
                            ),
                            const SizedBox(height: 35),
                            GetBack(
                              onTap: () => Get.toNamed('/mainDoc'),
                            ),
                            const SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {
                                _deletePatient(context);
                                Get.toNamed('/mainDoc');
                              },
                              child: const Text(
                                'Delete patient',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF724AB4),
                                ),
                              ),
                            ),
                            const SizedBox(height: 64.0),
                            CustomButton(
                              onPressed: () {
                                _addPatient(context);
                                Get.toNamed('/mainDoc');
                              },
                              buttonText: 'Add',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeaderText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF8067A9),
      ),
    );
  }

  final inputDecoration = InputDecoration(
    hintStyle: const TextStyle(color: Color(0xFF1D1B20)),
    filled: true,
    fillColor: Colors.white.withOpacity(0.2),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    ),
  );

  Future<void> _deletePatient(BuildContext context) async {
    final name = _nameController.text.trim();

    if (name.isNotEmpty) {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: name)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot userSnapshot = querySnapshot.docs.first;
        final userId = userSnapshot.id;

        await userSnapshot.reference
            .delete(); // Delete user document from Firestore

        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          final doctorId = currentUser.uid;
          await FirebaseFirestore.instance
              .collection('doctors')
              .doc(doctorId)
              .update({
            'supervised.$userId':
                FieldValue.delete() // Remove user from supervised list
          });

          // Refresh the HomeDoc screen
          // ignore: use_build_context_synchronously
          Navigator.popAndPushNamed(context, '/mainDoc');
        }
      } else {
        Get.snackbar('Error', 'User not found',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar('Error', 'Name field is required',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
