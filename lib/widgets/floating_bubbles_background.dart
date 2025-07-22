import 'package:flutter/material.dart';
import 'dart:math';

class FloatingBubblesBackground extends StatelessWidget {
  const FloatingBubblesBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(20, (index) {
        final random = Random(index);
        final size = random.nextDouble() * 60 + 20;
        final left = random.nextDouble() * MediaQuery.of(context).size.width;
        final top = random.nextDouble() * MediaQuery.of(context).size.height;

        return AnimatedPositioned(
          duration: Duration(milliseconds: 5000 + index * 100),
          curve: Curves.easeInOut,
          top: top,
          left: left,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // ignore: deprecated_member_use
              color: Colors.primaries[index % Colors.primaries.length].withOpacity(0.1),
            ),
          ),
        );
      }),
    );
  }
}
