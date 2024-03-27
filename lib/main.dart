import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/core/routes/route_config.dart';
import 'package:mini_ecommerce_app_assignment/core/services/firebase_notification.dart';
import 'package:mini_ecommerce_app_assignment/core/services/local_notification_service.dart';
import 'package:mini_ecommerce_app_assignment/core/theme/app_theme.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/provider/auth_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/others/providers/home_nav_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/presentation/providers/payment_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/product_provider.dart';
import 'package:mini_ecommerce_app_assignment/firebase_options.dart';
import 'package:mini_ecommerce_app_assignment/injection_container.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: "basic channel",
      title: message.notification?.title,
      body: message.notification?.body,
    ),
  );

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FireBaseNotification().initMessaging();
  await LocalNotification().initLocalNotification();
  await init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => sl<AuthProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<HomeNavProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<ProductsProvider>()..fetchAllProducts(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<PaymentProvider>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.appTheme(context),
      initialRoute: RouteConfig.wrapper,
      onGenerateRoute: RouteConfig.onGenerateRoute,
    );
  }
}
