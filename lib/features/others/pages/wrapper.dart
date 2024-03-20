import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/pages/login_page.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/provider/auth_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/others/pages/home.dart';
import 'package:provider/provider.dart';

class WrapperPage extends StatelessWidget {
  const WrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<AuthProvider>(
          builder: (context, provider, _) {
            print(provider.authStatus);
            switch (provider.authStatus) {
              case AuthStatus.authenticated:
                return const HomePage();
              case AuthStatus.unauthenticated:
                return const LoginPage();
              case AuthStatus.initial:
                return const LoginPage();
              default:
                const WrapperPage();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
