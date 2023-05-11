import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'core/route_generator.dart';
import 'core/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // print("red");
    _messageHandler;
  });

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

Future<void> _messageHandler(RemoteMessage message) async {
  // ignore: avoid_print
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  // List<String>? notificationList = prefs.getStringList('notification') ?? [];
  // notificationList.add(jsonEncode(message.data));
  // await prefs.setStringList('notification', notificationList);
  // int counter = prefs.getInt('counter') ?? 0;
  // int notificationCounter = counter + 1;
  // prefs.setInt("counter", notificationCounter);
  print('background message ${message.notification!.body.toString()}');
}
