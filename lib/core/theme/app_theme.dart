import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData appTheme(BuildContext context) => ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Theme.of(context).hintColor.withOpacity(0.04),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          isDense: true,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w300),
          suffixIconColor: Theme.of(context).hintColor.withOpacity(0.5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              Colors.black,
            ),
            foregroundColor: MaterialStateProperty.all(
              Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            foregroundColor: MaterialStateProperty.all(
              Colors.black,
            ),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      );
}
