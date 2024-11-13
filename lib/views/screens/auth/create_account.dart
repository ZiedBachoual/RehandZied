// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehand/model/services/firebase_auth_services.dart';
import 'package:rehand/views/widgets/get_back.dart';
import 'package:rehand/controller/validators.dart';
import 'package:rehand/views/widgets/toast.dart';

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

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  //text editing controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPatient = false;
  bool _isDoctor = false;
  bool _obscureText = true;
  late final String hintText;
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4F0),
      body: ListView(shrinkWrap: true, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 93.0),
              //Hello text
              const Text(
                'Hello!',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8067A9),
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Let\'s start a new account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8067A9),
                ),
              ),
              const SizedBox(height: 65.0),
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: inputDecoration.copyWith(
                        hintText: 'Username',
                      ),
                      validator: validateName,
                      controller: _usernameController,
                    ),
                    const SizedBox(height: 26.0),
                    TextFormField(
                      decoration: inputDecoration.copyWith(
                        hintText: 'Email',
                      ),
                      validator: validateEmail,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 26.0),
                    TextFormField(
                      controller: _passwordController,
                      validator: validatePassword,
                      obscureText: _obscureText,
                      decoration: inputDecoration.copyWith(
                        hintText: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 31.0),
              //are you a doc or patient text
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Are you a :',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8067A9),
                    ),
                  ),
                ],
              ),
              //checkbox for selecting patient or doc or therapist
              Row(
                children: [
                  Checkbox(
                    value: _isPatient,
                    onChanged: (newValue) {
                      setState(() {
                        _isPatient = newValue!;
                        _isDoctor = false;
                      });
                    },
                  ),
                  const Text(
                    'Patient',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8067A9),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Checkbox(
                    value: _isDoctor,
                    onChanged: (newValue) {
                      setState(() {
                        _isDoctor = newValue!;
                        _isPatient = false;
                      });
                    },
                  ),
                  const Text(
                    'Doctor/Physician',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8067A9),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30.0),
              //get back button
              GetBack(
                onTap: () {
                  Get.toNamed('/startingPage');
                },
              ),
              const SizedBox(height: 31.0),
              //Next page button
              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () {
                        //functionality for Next button
                        signUp();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(113.0, 60.0),
                        maximumSize: const Size(114.0, 61.0),
                        backgroundColor: const Color(0xFF8067A9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 6,
                      ),
                      icon: const Icon(Icons.arrow_forward_ios_outlined,
                          color: Colors.white),
                      label: const Text(
                        'Next',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void signUp() async {
    // Get user input
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Check if any user role is selected
    if (!_isPatient && !_isDoctor) {
      showToast(message: 'Select Patient, Doctor, or Therapist');
      return;
    }

    String role = "";

    try {
      // Create user with Firebase Authentication
      User? user = await _auth.signUpWithEmailAndPassword(email, password);

      if (user != null) {
        if (_isPatient) {
          role = 'patient';
          // Navigate to the next page
          Get.toNamed('/goal');
        } else if (_isDoctor) {
          role = 'doctor';
          // Navigate to the next page
          Get.toNamed('/mainDoc');
        }

        // Add user role to Firebase user data (if applicable)
        if (role.isNotEmpty) {
          // Check if a role was selected
          await _auth.updateUserRole(
              user.uid, role, email, _usernameController.text);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast(
            message: 'The email address is already in use by another account.');
      } else {
        showToast(message: 'An error occurred during registration.');
      }
    } catch (e) {
      showToast(message: 'An error occurred account creation.');
      // ignore: avoid_print
      print("Error occurred during account creation: $e");
    }
  }
}
