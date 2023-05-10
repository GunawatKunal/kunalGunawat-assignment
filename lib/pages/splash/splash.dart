import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false),
    );
    return const Scaffold(
      body: Center(
        child: Text(
          'SPLASH',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
