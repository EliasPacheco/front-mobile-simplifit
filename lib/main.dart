import 'package:flutter/material.dart';
import 'screens/intro_screen.dart';

void main() {
  runApp(const SimplifitApp());
}

class SimplifitApp extends StatelessWidget {
  const SimplifitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simplifit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const IntroScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
