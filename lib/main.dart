import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/core/theme/app_theme.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/pages/login_page.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/pages/sign_up_page.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/provider/auth_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/others/pages/home.dart';
import 'package:mini_ecommerce_app_assignment/features/others/pages/wrapper.dart';
import 'package:mini_ecommerce_app_assignment/firebase_options.dart';
import 'package:mini_ecommerce_app_assignment/injection_container.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => sl<AuthProvider>()..authUser(),
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
      // home: const SignUpPage(),
      initialRoute: '/wrapper',
      routes: {
        '/home': (context) => HomePage(),
        '/signUp': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
        '/wrapper': (context) => WrapperPage(),
      },
    );
  }
}
