import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.icon,
    required this.controller,
    required this.validator,
    this.onEditingComplete,
    this.focusNode,
  });

  final String title;
  final String hintText;
  final IconData? icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          onEditingComplete: onEditingComplete,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: Icon(icon),
          ),
        ),
      ],
    );
  }
}
