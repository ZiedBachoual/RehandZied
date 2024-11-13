import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehand/views/widgets/round_button.dart';

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    // Debug print to check the user details
    // ignore: avoid_print
    print("Current User: ${user?.uid}, Display Name: ${user?.displayName}");

    String username = user?.displayName ?? 'User_Name';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log out '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center  vertically
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor:
                      Colors.primaries[2 % Colors.primaries.length],
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            RoundButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.toNamed('/startingPage');
              },
              buttonText: 'Log out',
              hasIcon: true,
              icon: const Icon(Icons.logout_outlined,
                  size: 30.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
