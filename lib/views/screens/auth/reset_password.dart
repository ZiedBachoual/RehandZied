import 'package:rehand/views/widgets/get_back.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late final String hintText;
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDD1EB),
      body: SingleChildScrollView(
        child: Center(
          // Center the entire content
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the column vertically
            children: [
              const SizedBox(height: 400.0),
              // "Please Check your Email" text (centered)
              const Text(
                'Please Check your Email',
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8067A9),
                ),
                textAlign: TextAlign.center, // Center the text horizontally
              ),
              const SizedBox(height: 20.0),
              // "A link has been sent tou you" text (centered)
              const Text(
                'A link has been sent tou you',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8067A9),
                ),
                textAlign: TextAlign.center, // Center the text horizontally
              ),
              const SizedBox(height: 58),
              // GetBack button (already centered)
              GetBack(
                onTap: () {
                  Get.toNamed('/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
