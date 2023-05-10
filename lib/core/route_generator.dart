import 'package:flutter/material.dart';
import 'package:login_reg_demo/pages/login/login.dart';
import 'package:login_reg_demo/pages/register/register.dart';

import '../pages/splash/splash.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Route Error')),
        body: const Center(child: Text('Unhandled Route ERROR occured!')),
      );
    });
  }
}
