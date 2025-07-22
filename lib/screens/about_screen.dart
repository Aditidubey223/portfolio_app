
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:math';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
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
      animation: _controller,
      builder: (context, child) {
        final angle = _controller.value * 2 * pi + offsetAngle;
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
                  // ignore: duplicate_ignore
                  // ignore: deprecated_member_use
                  color.withOpacity(0.6),
                  color.withOpacity(0),
                ],
                stops: const [0.3, 1.0],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _section(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Text(
                  '• $item',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          _floatingCircle(
            color: const Color.fromARGB(255, 189, 206, 244),
            baseTop: 10,
            baseLeft: -40,
            size: 250,
            offsetAngle: 0,
            offsetRadius: 20,
          ),
          _floatingCircle(
            color: const Color.fromARGB(255, 239, 249, 169),
            baseTop: screenSize.height * 0.4,
            baseLeft: screenSize.width * 0.65,
            size: 280,
            offsetAngle: pi / 2,
            offsetRadius: 25,
          ),
          _floatingCircle(
            color: const Color.fromARGB(255, 251, 236, 180),
            baseTop: screenSize.height * 0.8,
            baseLeft: -30,
            size: 280,
            offsetAngle: pi,
            offsetRadius: 30,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(25, 50, 25, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/aditidubeyprofile.jpg',
                          width: 165,
                          height: 165,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Aditi Dubey',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Color.fromARGB(255, 44, 45, 46),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Developer & Designer · Madhya Pradesh, India',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Hi! I’m a curious and creative UI/UX Designer and Flutter App Developer passionate about crafting intuitive, delightful digital products. I specialize in transforming complex problems into simple, user-friendly solutions.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _section("Languages", [
                  "Java, Python, Dart, Kotlin, C++",
                ]),
                _section("Web Technologies", [
                  "HTML, CSS, JavaScript (Basics), REST APIs",
                ]),
                _section("Frameworks & Libraries", [
                  "Flutter, Node.js, Provider (State Management)",
                ]),
                _section("Tools & Platforms", [
                  "Git, GitHub, Firebase, Figma",
                ]),
                _section("Databases", [
                  "MongoDB, Firebase, PostgreSQL (Basics)",
                ]),
                _section("UI/UX Design", [
                  "User Research & Persona Building",
                  "Wireframing & Prototyping",
                  "Design Thinking Approach",
                  "Accessibility & Usability Principles",
                ]),
                _section("Design Tools", [
                  "Figma (Primary)",
                  "Adobe XD, Canva, Photoshop (Basic)",
                  "LottieFiles for motion design",
                  "FigJam for collaborative brainstorming",
                ]),
                _section("Visual & Interaction Design", [
                  "Layout design and grid systems",
                  "Typography and color theory",
                  "Branding & visual consistency",
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
