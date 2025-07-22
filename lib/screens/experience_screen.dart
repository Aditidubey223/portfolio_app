
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:math';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen>
    with TickerProviderStateMixin {
  late AnimationController _circleController;
  String selectedCategory = 'All';

  final Map<String, Color> categoryColors = {
    'Internships': const Color(0xFFF05924),
    'Graphic Design': const Color(0xFFEAC439),
    'Community': const Color(0xFFCFB649),
    'Freelance': const Color(0xFF163438),
  };

  final List<Map<String, dynamic>> experiences = [
    {
      'title': 'AI & Mobile App Intern',
      'company': 'CDAC Mohali',
      'category': 'Internships',
      'duration': 'Aug 2024 – Present',
      'description':
          'Working on AI-powered mobile applications using Flutter and React Native.',
      'icon': Icons.smartphone,
    },
    {
      'title': 'UI Designer',
      'company': 'Ambimed Healthcare',
      'category': 'Internships',
      'duration': 'Apr 2024 – Present',
      'description':
          'Designing clean and accessible user interfaces for health platforms.',
      'icon': Icons.design_services,
    },
    {
      'title': 'Graphic Designer',
      'company': 'Oasis Infobyte',
      'category': 'Graphic Design',
      'duration': 'Jul 2023 – Aug 2023',
      'description':
          'Created posters, logos, and brand assets for multiple client projects.',
      'icon': Icons.brush,
    },
    {
      'title': 'Core Team Member & Designer',
      'company': 'CodeIN, Coders Evoke, PiNotif, Let\'s Build Together',
      'category': 'Community',
      'duration': '2021 – 2024',
      'description':
          'Led community branding, created posters and helped organize hackathons.',
      'icon': Icons.groups,
    },
    {
      'title': 'Freelance Designer',
      'company': 'AlgoTutor, Interview Cafe, Bolt Software',
      'category': 'Freelance',
      'duration': '2022 – 2024',
      'description':
          'Designed logos, banners, and built strong brand identity for startups.',
      'icon': Icons.work_outline,
    },
  ];

  @override
  void initState() {
    super.initState();
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _circleController.dispose();
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

  Widget _categoryTabs() {
    final tabs = ['All', ...categoryColors.keys];
    return Wrap(
      spacing: 12,
      runSpacing: 10,
      children: tabs.map((tab) {
        final isSelected = selectedCategory == tab;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedCategory = tab;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.black87 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tab,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _experienceCard(Map<String, dynamic> exp) {
    final color = categoryColors[exp['category']] ?? Colors.grey;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.95, end: 1),
      duration: const Duration(milliseconds: 600),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.8), color.withOpacity(0.4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                Icon(exp['icon'], size: 32, color: Colors.white),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exp['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        exp['company'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        exp['duration'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        exp['description'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final filtered = selectedCategory == 'All'
        ? experiences
        : experiences.where((e) => e['category'] == selectedCategory).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _floatingCircle(
            color: Colors.pinkAccent,
            baseTop: 100,
            baseLeft: -60,
            size: 200,
            offsetAngle: 0,
            offsetRadius: 40,
          ),
          _floatingCircle(
            color: Colors.blueAccent,
            baseTop: screenSize.height * 0.5,
            baseLeft: screenSize.width * 0.7,
            size: 180,
            offsetAngle: pi / 2,
            offsetRadius: 35,
          ),
          _floatingCircle(
            color: Colors.orangeAccent,
            baseTop: screenSize.height * 0.85,
            baseLeft: -40,
            size: 220,
            offsetAngle: pi,
            offsetRadius: 30,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Experience',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                _categoryTabs(),
                const SizedBox(height: 24),
                ...filtered.map(_experienceCard),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
