
// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:flutter/material.dart';
import '../models/project.dart';

class ProjectDetailScreen extends StatefulWidget {
  final Project project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _circleController;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Start fade-in after slight delay
    Future.delayed(const Duration(milliseconds: 300), () {
      _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _circleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Offset _circularOffset(double angle, double radius) {
    return Offset(cos(angle) * radius, sin(angle) * radius);
  }

  Widget _floatingCircle({
    required Color color,
    required double baseTop,
    required double baseLeft,
    required double size,
    required double offsetAngle,
    required double offsetRadius,
  }) {
    return AnimatedBuilder(
      animation: _circleController,
      builder: (context, child) {
        final angle = _circleController.value * 2 * pi + offsetAngle;
        final offset = _circularOffset(angle, offsetRadius);

        return Positioned(
          top: baseTop + offset.dy,
          left: baseLeft + offset.dx,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color.withOpacity(0.5),
                  color.withOpacity(0.0),
                ],
                stops: const [0.3, 1.0],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final isUX = project.category == "UI/UX";
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(project.title),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _floatingCircle(
            color: Colors.purpleAccent,
            baseTop: 80,
            baseLeft: -60,
            size: 220,
            offsetAngle: 0,
            offsetRadius: 45,
          ),
          _floatingCircle(
            color: Colors.lightBlue,
            baseTop: screenSize.height * 0.5,
            baseLeft: screenSize.width * 0.7,
            size: 180,
            offsetAngle: pi / 2,
            offsetRadius: 35,
          ),
          _floatingCircle(
            color: Colors.orange,
            baseTop: screenSize.height * 0.85,
            baseLeft: -40,
            size: 250,
            offsetAngle: pi,
            offsetRadius: 30,
          ),
          FadeTransition(
            opacity: _fadeController,
            child: SlideTransition(
              position: _fadeController.drive(
                Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'project_${project.title}',
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [Colors.deepPurpleAccent, Colors.pinkAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurpleAccent.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 6),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              project.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              project.subtitle,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text("Description",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black87)),
                    const SizedBox(height: 6),
                    Text(project.description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black54)),
                    const SizedBox(height: 24),
                    Text("Problem",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black87)),
                    const SizedBox(height: 6),
                    Text(project.problem, style: const TextStyle(color: Colors.black87)),
                    const SizedBox(height: 24),
                    Text(isUX ? "Solution" : "Overview",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black87)),
                    const SizedBox(height: 6),
                    Text(project.solution, style: const TextStyle(color: Colors.black87)),
                    if (isUX) ...[
                      const SizedBox(height: 24),
                      if (project.githubLink.isNotEmpty)
                        Text("🔗 GitHub: ${project.githubLink}", style: const TextStyle(color: Colors.black)),
                      if (project.liveLink != null)
                        Text("🌐 Live: ${project.liveLink}", style: const TextStyle(color: Colors.black)),
                    ] else if (project.gallery != null) ...[
                      const SizedBox(height: 24),
                      Text("Key Features",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black87)),
                      const SizedBox(height: 8),
                      ...project.gallery!.map((img) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(img, fit: BoxFit.cover),
                            ),
                          )),
                    ]
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
