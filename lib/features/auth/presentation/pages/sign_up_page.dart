import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/core/command/sign_up_command.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/provider/auth_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confrimPasswordController =
      TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confrimPasswordFocusNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confrimPasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confrimPasswordFocusNode.dispose();
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
                "Create an account",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                "Let's create your account.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 12,
              ),
              AuthTextField(
                title: "Full Name",
                hintText: "Enter your full name",
                controller: _userNameController,
                validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
                onEditingComplete: _emailFocusNode.requestFocus,
              ),
              AuthTextField(
                title: 'Email',
                hintText: "Enter your email address",
                controller: _emailController,
                focusNode: _emailFocusNode,
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
                onEditingComplete: _confrimPasswordFocusNode.requestFocus,
              ),
              AuthTextField(
                obSecure: true,
                title: "Confirm Password",
                hintText: "Please enter password again",
                controller: _confrimPasswordController,
                focusNode: _confrimPasswordFocusNode,
                validator: (value) => value != _passwordController.text
                    ? "Password does not match"
                    : value?.isEmpty == true
                        ? "Required"
                        : null,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() != true) return;
                  final signUpCommand = SignUpCommand(
                    email: _emailController.text,
                    name: _userNameController.text,
                    password: _passwordController.text,
                  );
                  final isSuccess =
                      await authProvider.signUpwithEmail(signUpCommand);
                  if (isSuccess) {
                    if (!context.mounted) return;
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/home', (route) => false);
                  } else {
                    print("Register Failed");
                  }
                },
                child: const Text("Sign Up"),
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
                    "Already a member?",
                  ),
                  Text(
                    "Log In",
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
