import 'package:flutter/material.dart';

class GetBack extends StatelessWidget {
  final VoidCallback onTap;

  const GetBack({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.arrow_circle_left_outlined,
            color: Color(0xFF724AB4), size: 30),
        const SizedBox(
          width: 10.0,
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            'Get Back',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF724AB4),
            ),
          ),
        ),
      ],
    );
  }
}
