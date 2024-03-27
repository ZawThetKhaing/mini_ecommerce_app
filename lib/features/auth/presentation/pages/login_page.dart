import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/core/command/login_command.dart';
import 'package:mini_ecommerce_app_assignment/core/routes/route_config.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/provider/auth_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _passwordFocusNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.only(
              top: 40,
              left: 24,
              right: 24,
              bottom: 24,
            ),
            children: [
              Text(
                "Welcome back.",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                "Let's login for fantastic experience.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 12,
              ),
              AuthTextField(
                title: 'Email',
                hintText: "Enter your email address",
                controller: _emailController,
                validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
                onEditingComplete: _passwordFocusNode.requestFocus,
              ),
              AuthTextField(
                obSecure: true,
                title: "Password",
                hintText: "Enter your password",
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() != true) return;
                  final loginCommand = LoginCommand(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  final isSuccess =
                      await authProvider.loginWithEmail(loginCommand);
                  if (isSuccess) {
                    if (!context.mounted) return;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        RouteConfig.home, (route) => false);
                  } else {
                    //ToDo :: Login Failed
                  }
                },
                child: const Text("Login"),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text("Or"),
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PhosphorIcon(PhosphorIconsFill.googleLogo),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Sign Up with Google")
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Create a new account.",
                  ),
                  Text(
                    "Sign Up",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
