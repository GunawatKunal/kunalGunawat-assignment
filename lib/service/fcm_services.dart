// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:login_reg_demo/core/theme.dart';

fcmPermissionForIosWeb() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}

Future<void> fcmMessaging(BuildContext context) async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await FirebaseMessaging.instance.subscribeToTopic('red').then((_) => print('FCM Subscribed to red'));
  await FirebaseMessaging.instance.getInitialMessage();
  await messaging.getToken().then((value) {
    print(value.toString());
  });

  // if want to post fcm token
  // FirebaseMessaging.instance.onTokenRefresh.listen(await messaging.getToken().then((value) {
  //   return putFcmToken(context, fcmToken: value.toString());
  // }));

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      showDialog(
        context: context,
        builder: (_) => Dialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Text("New Notification Recived"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.notification!.title.toString().toCapitalized(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      message.notification!.body.toString().toCapitalized(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    const Divider(height: 2),
                    const SizedBox(height: 20),
                    GestureDetector(onTap: () => Navigator.pop(context), child: const Text("Okay")),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print('Message clicked!');
  });
}
