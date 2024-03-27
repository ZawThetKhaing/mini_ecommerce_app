import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hintText;
  final int? maxLine;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.onEditingComplete,
    this.validator,
    this.hintText,
    this.maxLine,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        focusNode: focusNode,
        validator:
            validator ?? (value) => value?.isEmpty == true ? "Required" : null,
        maxLines: maxLine,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}
