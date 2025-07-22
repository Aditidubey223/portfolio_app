import 'package:flutter/material.dart';
import '../widgets/floating_navbar.dart';
import 'home_screen.dart';
import 'experience_screen.dart';
import 'about_screen.dart';
import 'contact_screen.dart';
import 'project_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
      HomeScreen(),        // 0
      ExperienceScreen(),  // 1
      AboutScreen(),       // 2
      ProjectScreen(),     // 
      ContactScreen(),     //
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Required for floating navbar to show over content
      body: Stack(
        children: [
          _screens[_currentIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Center(
              child: FloatingNavBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
