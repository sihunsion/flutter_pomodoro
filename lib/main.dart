import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Color(0XFF232B55),
            ),
          ),
          cardColor: const Color(0xFFF4EDDB),
          scaffoldBackgroundColor: const Color(0xFFE7626C)),
      home: const HomeScreen(),
    );
  }
}
