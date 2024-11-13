import 'package:flutter/material.dart';

class PatientCard extends StatelessWidget {
  final String name;
  final String injuryType;
  final Color avatarColor;
  final VoidCallback onTap;

  const PatientCard({
    super.key,
    required this.name,
    required this.injuryType,
    required this.avatarColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        color: Colors.blue.shade200,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: avatarColor,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 9.0),
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(height: 19.0),
              const Text(
                'Injury type:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(injuryType),
            ],
          ),
        ),
      ),
    );
  }
}
