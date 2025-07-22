// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FloatingNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home, 0, 'Home'),
          _navItem(Icons.work_outline, 1, 'Experience'),
          _navItem(Icons.person_outline, 2, 'About'),
          _navItem(Icons.folder_open, 3, 'Projects'),  // <-- NEW Projects Tab
          _navItem(Icons.mail_outline, 4, 'Contact'),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, int index, String tooltip) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Tooltip(
        message: tooltip,
        child: Icon(
          icon,
          color: currentIndex == index ? Colors.white : Colors.grey[400],
          size: 28,
        ),
      ),
    );
  }
}
