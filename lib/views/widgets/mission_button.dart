import 'package:flutter/material.dart';

class MissionButton extends StatefulWidget {
  final String missionTitle;
  final String missionDescription;
  final VoidCallback onTap;

  const MissionButton({
    super.key,
    required this.missionTitle,
    required this.missionDescription,
    required this.onTap,
  });

  @override
  State<MissionButton> createState() => _MissionButtonState();
}

class _MissionButtonState extends State<MissionButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isSelected = !_isSelected;
                widget.onTap();
              });
            },
            child: Container(
              height: 95.0,
              width: 315.0,
              decoration: BoxDecoration(
                color: _isSelected
                    ? Colors.lightGreenAccent.shade700
                    : Colors.deepPurple.shade300,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.missionTitle,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          widget.missionDescription,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_isSelected) // Conditionally show the icon
                    const Padding(
                      padding: EdgeInsets.only(right: 30.0),
                      child: Icon(Icons.check, color: Colors.black),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
