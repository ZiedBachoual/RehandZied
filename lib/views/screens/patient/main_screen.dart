import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rehand/views/screens/auth/logout_page.dart';
import 'package:rehand/views/screens/patient/chat/chat.dart';
import 'package:rehand/views/screens/patient/dashboard.dart';
import 'package:rehand/views/screens/patient/home_patient.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  Color bgcolor = Colors.transparent;
  Color navcolor = Colors.deepPurple.shade200;

  final List<Widget> _navigationItem = [
    const Icon(Icons.home_filled),
    const Icon(Icons.dashboard_rounded),
    const Icon(Icons.favorite),
    const Icon(Icons.settings),
  ];

  final List<Widget> _screens = [
    const HomePat(),
    const Dash(),
    const Chat(),
    const LogOut(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: bgcolor,
        items: _navigationItem,
        color: navcolor,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() => _selectedIndex = index);
          switch (index) {
            case 0:
              bgcolor = Colors.transparent;
              navcolor = Colors.deepPurple.shade200;
              break;
            case 1:
              bgcolor = const Color(0xFF8068A6);
              navcolor = Colors.deepPurple.shade200;
              break;
            case 2:
              bgcolor = const Color(0xFFBFB0D1);
              navcolor = Colors.white;
              break;
            case 3:
              bgcolor = Colors.transparent;
              navcolor = Colors.deepPurple.shade200;
              break;
            default:
          }
        },
      ),
    );
  }
}
