import 'package:flutter/material.dart';
import 'package:rishi_portfolio/splash_animation_screen.dart';
import 'package:rishi_portfolio/utils/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeNotifier.themeMode,
      builder: (context, themeMode, child) {
        return MaterialApp(
          title: 'Rishi\'s Portfolio',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeNotifier.themeMode.value,
          home: HelloAnimationFixed(),
          debugShowCheckedModeBanner: false,
        );
      }
    );
  }
}
