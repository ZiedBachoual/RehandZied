import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rehand/views/screens/auth/logout_page.dart';
import 'package:rehand/views/screens/doctor/chat/chat_home.dart';
import 'package:rehand/views/screens/doctor/home_doc.dart';

class MainScreenDoc extends StatefulWidget {
  const MainScreenDoc({super.key});

  @override
  State<MainScreenDoc> createState() => _MainScreenDocState();
}

class _MainScreenDocState extends State<MainScreenDoc> {
  int _selectedIndex = 0;
  Color bgcolor = Colors.transparent;
  Color navcolor = Colors.deepPurple.shade200;

  final List<Widget> _navigationItem = [
    const Icon(Icons.home_filled),
    const Icon(Icons.favorite),
    const Icon(Icons.settings),
  ];

  final List<Widget> _screens = [
    HomeDoc(),
    const ChatHome(),
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
              bgcolor = const Color(0xFFBFB0D1);
              navcolor = Colors.white;
              break;
            case 2:
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
