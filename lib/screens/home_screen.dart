import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
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
                  // ignore: deprecated_member_use
                  color.withOpacity(0.6),
                  // ignore: deprecated_member_use
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.white, // or any preferred background
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
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 50, 25, 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/aditidubeyprofile.jpg',
                      width: 185,
                      height: 185,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Hey there! I’m Aditi 👋',

                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 44, 45, 46),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 15),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        height: 1.4,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'A passionate designer & developer navigating the universe of creativity. Welcome to my\n',
                        ),
                        TextSpan(
                          text: 'Portfolioverse',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 44, 45, 46),
                          ),
                        ),
                        TextSpan(
                          text: ' — where ideas come alive.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Resume button clicked")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: const Text('Resume'),
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


