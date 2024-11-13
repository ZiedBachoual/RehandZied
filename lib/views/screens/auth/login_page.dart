// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rehand/controller/validators.dart';
import 'package:rehand/model/services/firebase_auth_services.dart';
import 'package:rehand/views/widgets/get_back.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehand/views/widgets/custom_button.dart';
import 'package:rehand/views/widgets/toast.dart';

late final String hintText;
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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  // ignore: unused_field
  final FirebaseAuthService _auth = FirebaseAuthService();
  //text editing controllers
  // ignore: unused_field
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDD1EB),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 210.0),
              //Welcome back text
              const Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF724AB4),
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: inputDecoration.copyWith(
                        hintText: 'Email',
                      ),
                      validator: validateEmail,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 26),
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
              const SizedBox(height: 44),
              //Reset password button

              GestureDetector(
                onTap: () async {
                  if (_emailController.text.isEmpty) {
                    showToast(message: 'Please write your Email');
                  } else {
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: _emailController.text,
                      );
                      Get.toNamed('/resetPass');
                    } catch (e) {
                      showToast(
                          message: 'Failed to reset password.Please try later');
                    }
                  }
                },
                child: const Text(
                  'Reset your Password',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF724AB4),
                  ),
                ),
              ),

              const SizedBox(height: 43),
              //get back button
              GetBack(
                onTap: () {
                  Get.toNamed('/startingPage');
                },
              ),
              const SizedBox(height: 95.0),
              //LogIn button
              CustomButton(
                onPressed: () {
                  //functionality for Login button
                  logIn();
                },
                buttonText: 'Login',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      // Call to sign in with email and password
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Extract the actual User object from the credential
      User? user = userCredential.user;

      if (user != null) {
        print("User successfully logged in: ${user.uid}");

        // Fetch user document and navigate based on role
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get()
            .then((userDoc) {
          if (userDoc.exists) {
            String role = userDoc.data()!['role'];
            if (role == 'patient') {
              Get.toNamed('/mainPat');
            } else if (role == 'doctor') {
              Get.toNamed('/mainDoc');
            } else {
              // Handle unexpected role scenario
              print("Unexpected user role: $role");
            }
          } else {
            print("User document not found");
          }
        });
      } else {
        print("Login failed");
        showToast(
            message:
                'Login failed. Please check your credentials or network connection.');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        showToast(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that email.');
        showToast(message: 'Wrong password provided for that email.');
      } else {
        print('Login failed with code: ${e.code}');
        showToast(message: 'Login failed. Please try again.');
      }
    }
  }
}
