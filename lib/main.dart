import 'package:flutter/material.dart';

import 'core/route_generator.dart';
import 'core/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'reg-login',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: buildThemeData(),
    );
  }
}
