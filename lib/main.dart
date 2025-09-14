import 'package:flutter/material.dart';
import 'home_page.dart';
import 'onboarding_screens.dart';
import 'sign.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Snapchat Clone',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      // Start at Auth first
      home: const sign(),
      // Define routes
      routes: {
        '/auth': (context) => const AuthScreen(),
        '/home': (context) => const HomeScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
      },
    );
  }
}