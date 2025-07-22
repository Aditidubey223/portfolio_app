import 'package:flutter/material.dart';
import 'screens/main_layout.dart';
import 'screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio App',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const MainLayout(), // Includes floating navbar
      },
    );
  }
}
