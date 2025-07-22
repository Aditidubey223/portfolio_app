

import 'package:flutter/material.dart';
import '../models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;

  const ProjectCard({super.key, required this.project, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final List<List<Color>> gradients = [
      [Colors.pinkAccent, Colors.deepPurple],
      [Colors.orangeAccent, Colors.redAccent],
      [Colors.lightBlueAccent, Colors.teal],
      [Colors.purpleAccent, Colors.indigoAccent],
    ];
    final gradient = gradients[project.title.hashCode % gradients.length];

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: gradient.first.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              project.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              project.subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
