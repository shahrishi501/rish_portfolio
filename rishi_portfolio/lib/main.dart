import 'package:flutter/material.dart';
import 'package:rishi_portfolio/home_screen.dart';
import 'package:rishi_portfolio/splash_animation_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rishi\'s Portfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        
        fontFamily: 'Inter'),
      home: HelloAnimationFixed(),
      debugShowCheckedModeBanner: false,
    );
  }
}
