import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100,
            borderRadius: BorderRadius.circular(40),
          ),
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 25),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              //Icon
              const Icon(Icons.person),
              const SizedBox(width: 20),
              //username
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
