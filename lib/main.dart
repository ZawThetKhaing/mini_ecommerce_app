import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/core/theme/app_theme.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/pages/sign_up_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.appTheme(context),
      home: const SignUpPage(),
    );
  }
}
