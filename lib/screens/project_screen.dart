import 'dart:math';
import 'package:flutter/material.dart';
import '../data/project_data.dart';
import 'project_detail_screen.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen>
    with TickerProviderStateMixin {
  late AnimationController _circleController;
  String selectedCategory = 'All';

  final List<String> categories = ['All', 'UI/UX', 'App', 'Web', 'Other'];

  final Map<String, Color> categoryColors = {
    'UI/UX': Colors.pinkAccent,
    'App': Colors.blueAccent,
    'Web': Colors.teal,
    'Other': Colors.orangeAccent,
  };

  @override
  void initState() {
    super.initState();
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
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
                  // ignore: deprecated_member_use
                  color.withOpacity(0.5),
                  // ignore: deprecated_member_use
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
    return Wrap(
      spacing: 12,
      runSpacing: 10,
      children: categories.map((tab) {
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

  Widget _projectCard(project) {
    final color = categoryColors[project.category] ?? Colors.deepPurpleAccent;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProjectDetailScreen(project: project),
            ),
          );
        },
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.0, end: 1.0),
          duration: const Duration(milliseconds: 400),
          builder: (context, scale, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    // ignore: deprecated_member_use
                    color.withOpacity(0.85),
                    // ignore: deprecated_member_use
                    color.withOpacity(0.45),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: color.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    project.subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    project.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final filteredProjects = selectedCategory == 'All'
        ? projectList
        : projectList
            .where((p) => p.category == selectedCategory)
            .toList();

    return Scaffold(
      backgroundColor: Colors.white,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Projects',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                _categoryTabs(),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    itemCount: filteredProjects.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.9, // Equal-shaped cards
                    ),
                    itemBuilder: (context, index) {
                      return _projectCard(filteredProjects[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
