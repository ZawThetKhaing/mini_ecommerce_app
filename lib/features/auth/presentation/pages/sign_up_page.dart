import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
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
            const AuthTextField(
              title: "Full Name",
              hintText: "Enter your full name",
            ),
            const AuthTextField(
              title: 'Email',
              hintText: "Enter your email address",
            ),
            const AuthTextField(
              title: "Password",
              hintText: "Enter your password",
            ),
            const AuthTextField(
              title: "Confirm Password",
              hintText: "Please enter password again",
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () {},
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
    );
  }
}
