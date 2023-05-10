import 'package:flutter/material.dart';
import 'package:login_reg_demo/core/theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false),
    );
    return const Scaffold(
      body: Center(child: AnimatedLogo()),
    );
  }
}

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({
    super.key,
  });

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: RotationTransition(
            turns: animationController,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(blurRadius: 3, spreadRadius: 1, color: Color(0xFF37FF9F), offset: Offset(0, 4))
                ],
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [AppColor.primaryColor.withOpacity(1), AppColor.primaryColor.withOpacity(0.4)]),
              ),
              height: MediaQuery.of(context).size.width * 0.2,
              width: MediaQuery.of(context).size.width * 0.2,
            ),
          ),
        ),
        const Center(
          child: Text(
            'SPLASH',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
