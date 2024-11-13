import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool hasIcon; // indicate presence of icon
  final Icon? icon; // Make icon nullable

  const RoundButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.hasIcon = false, // Set default to false
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(267.0, 61.0),
            maximumSize: const Size(268.0, 62.0),
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF8067A9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align content to left
            children: [
              if (hasIcon) icon!, // Show icon if hasIcon is true
              Padding(
                padding: const EdgeInsets.only(left: 55), // Add left padding
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
