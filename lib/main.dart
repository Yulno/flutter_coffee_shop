import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_shop/firebase_options.dart';
import 'package:flutter_coffee_shop/src/common/push_notifications/push_notifications.dart';
import 'package:flutter_coffee_shop/src/features/menu/bloc/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/app.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = const Observer();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    LocalNotification.initialize();

    FirebaseMessaging.onMessage
        .listen((message) => LocalNotification.display(message));

    runApp(const CoffeeShopApp());
  }, (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });
}