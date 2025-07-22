// import 'package:flutter/material.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           buildRadialCircle(size: 150, alignment: Alignment.topLeft),
//           buildRadialCircle(size: 50, alignment: Alignment.bottomRight),

//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset('assets/splash.png'),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Welcome',
//                   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 5.5,
//                     vertical: 10,
//                   ),
//                   child: RichText(
//                     textAlign: TextAlign.center,
//                     text: TextSpan(
//                       text: 'This is my ',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         color: Colors.black,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.w400,
//                       ),
//                       children: <TextSpan>[
//                         TextSpan(
//                           text: 'Portfolioverse:\n',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: const Color.fromARGB(255, 77, 78, 78),
//                           ),
//                         ),
//                         const TextSpan(
//                           text:
//                               ' An evolving gallery of digital design and development.',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // const Text(
//                 //    softWrap: true,
//                 //    textAlign: TextAlign.center,
//                 //   'This is my Portfolioverse: \na curated universe of designs, projects, \nand creative energy.',
//                 //   style: TextStyle(fontSize: 16, color: Colors.grey),
//                 // ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Widget _buildBlurCircle(double size, Color color) {
// //   return Container(
// //     width: size,
// //     height: size,
// //     decoration: BoxDecoration(
// //       shape: BoxShape.circle,
// //       color: color,
// //       boxShadow: [BoxShadow(color: color, blurRadius: 80, spreadRadius: 30)],
// //     ),
// //   );
// // }

// Widget buildRadialCircle({required double size, required Alignment alignment}) {
//   return Align(
//     alignment: alignment,
//     child: Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         gradient: const RadialGradient(
//           colors: [
//             Color(0xFF407BFF), // Inner color
//             Color(0xFF40DDFF), // Outer color
//           ],
//           center: Alignment.center,
//           radius: 0.8,
//         ),
//         boxShadow: [
//           BoxShadow(
//             // ignore: deprecated_member_use
//             color: Color(0xFF40DDFF).withOpacity(0.4),
//             blurRadius: 100,
//             spreadRadius: 60,
//           ),
//         ],
//       ),
//     ),
//   );
// }


// import 'package:flutter/material.dart';
// import 'dart:math';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 25),
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   // Helper to animate in circle pattern
//   Offset _circularOffset(double angle, double radius) {
//     return Offset(cos(angle) * radius, sin(angle) * radius);
//   }

//   Widget _floatingCircle({
//     required Color color,
//     required double baseTop,
//     required double baseLeft,
//     required double size,
//     required double offsetAngle,
//     required double offsetRadius,
//   }) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         final angle = _controller.value * 2 * pi + offsetAngle;
//         final offset = _circularOffset(angle, offsetRadius);

//         return Positioned(
//           top: baseTop + offset.dy,
//           left: baseLeft + offset.dx,
//           child: Container(
//             width: size,
//             height: size,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: RadialGradient(
//                 colors: [
//                   // ignore: deprecated_member_use
//                   color.withOpacity(0.6),
//                   // ignore: deprecated_member_use
//                   color.withOpacity(0),
//                 ],
//                 stops: const [0.3, 1.0],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Blurred animated background circles based on your image
//           _floatingCircle(
//             color: const Color.fromARGB(255, 189, 206, 244), // Blue top left
//             baseTop: 10,
//             baseLeft: -40,
//             size: 250,
//             offsetAngle: 0,
//             offsetRadius: 20,
//           ),
//           _floatingCircle(
//             color: const Color.fromARGB(255, 239, 249, 169), // Yellow right middle
//             baseTop: 300,
//             baseLeft: 250,
//             size: 280,
//             offsetAngle: pi / 2,
//             offsetRadius: 25,
//           ),
//           _floatingCircle(
//             color: const Color.fromARGB(255, 251, 236, 180), // Green bottom left
//             baseTop: 700,
//             baseLeft: -30,
//             size: 280,
//             offsetAngle: pi,
//             offsetRadius: 30,
//           ),

//           // Foreground content — unchanged
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset('assets/splash.png'), // ← Keeps your image size
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Welcome',
//                   style: TextStyle(
//                     fontSize: 40,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 5.5, vertical: 10),
//                   child: RichText(
//                     textAlign: TextAlign.center,
//                     text: TextSpan(
//                       text: 'This is my ',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         color: Colors.black,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.w400,
//                       ),
//                       children: <TextSpan>[
//                         TextSpan(
//                           text: 'Portfolioverse:\n',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: const Color.fromARGB(255, 77, 78, 78),
//                           ),
//                         ),
//                         const TextSpan(
//                           text:
//                               ' An evolving gallery of digital design and development.',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'dart:math';
// import 'home_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 4), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     });
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 25),
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Offset _circularOffset(double angle, double radius) {
//     return Offset(cos(angle) * radius, sin(angle) * radius);
//   }

//   Widget _floatingCircle({
//     required Color color,
//     required double baseTop,
//     required double baseLeft,
//     required double size,
//     required double offsetAngle,
//     required double offsetRadius,
//   }) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         final angle = _controller.value * 2 * pi + offsetAngle;
//         final offset = _circularOffset(angle, offsetRadius);

//         return Positioned(
//           top: baseTop + offset.dy,
//           left: baseLeft + offset.dx,
//           child: Container(
//             width: size,
//             height: size,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: RadialGradient(
//                 colors: [
//                   // ignore: deprecated_member_use
//                   color.withOpacity(0.6),
//                   // ignore: deprecated_member_use
//                   color.withOpacity(0),
//                 ],
//                 stops: const [0.3, 1.0],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           _floatingCircle(
//             color: const Color.fromARGB(255, 189, 206, 244),
//             baseTop: 10,
//             baseLeft: -40,
//             size: 250,
//             offsetAngle: 0,
//             offsetRadius: 20,
//           ),
//           _floatingCircle(
//             color: const Color.fromARGB(255, 239, 249, 169),
//             baseTop: screenSize.height * 0.4,
//             baseLeft: screenSize.width * 0.65,
//             size: 280,
//             offsetAngle: pi / 2,
//             offsetRadius: 25,
//           ),
//           _floatingCircle(
//             color: const Color.fromARGB(255, 251, 236, 180),
//             baseTop: screenSize.height * 0.8,
//             baseLeft: -30,
//             size: 280,
//             offsetAngle: pi,
//             offsetRadius: 30,
//           ),

//           Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Image.asset(
//                     'assets/splash.png',
//                     width: screenSize.width * 2,
//                     fit: BoxFit.contain,
//                   ),
//                   const SizedBox(height: 30),
//                   const Text(
//                     'Welcome',
//                     style: TextStyle(
//                       fontSize: 40,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Poppins',
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   RichText(
//                     textAlign: TextAlign.center,
//                     text: const TextSpan(
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.black,
//                         fontFamily: 'Poppins',
//                         height: 1.4,
//                       ),
//                       children: <TextSpan>[
//                         TextSpan(text: 'This is my '),
//                         TextSpan(
//                           text: 'Portfolioverse:\n',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w700,
//                             color: Color.fromARGB(255, 44, 45, 46),
//                           ),
//                         ),
//                         TextSpan(
//                           text:
//                               'An evolving gallery of digital design and development.',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    
    // ✅ Navigate to MainLayout via named route so navbar works
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/home');
    });

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/splash.png',
                    width: screenSize.width * 2,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 40,
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
                        TextSpan(text: 'This is my '),
                        TextSpan(
                          text: 'Portfolioverse:\n',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 44, 45, 46),
                          ),
                        ),
                        TextSpan(
                          text:
                              'An evolving gallery of digital design and development.',
                        ),
                      ],
                    ),
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
