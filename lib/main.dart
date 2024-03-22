import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/core/routes/route_config.dart';
import 'package:mini_ecommerce_app_assignment/core/theme/app_theme.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/provider/auth_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/others/providers/home_nav_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/product/presentation/providers/get_product_provider.dart';
import 'package:mini_ecommerce_app_assignment/firebase_options.dart';
import 'package:mini_ecommerce_app_assignment/injection_container.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => sl<AuthProvider>()..authUser(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<HomeNavProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<GetProductsProvider>()..fetchAllProducts(),
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
      initialRoute: '/wrapper',
      onGenerateRoute: RouteConfig.onGenerateRoute,
    );
  }
}
