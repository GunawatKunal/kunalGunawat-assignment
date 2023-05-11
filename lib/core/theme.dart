import 'package:flutter/material.dart';

ThemeData buildThemeData() {
  return ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 15, fontWeight: FontWeight.normal),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.primaryColor)),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.primaryColor)),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.primaryColor)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColor.primaryColor),
        fixedSize: MaterialStateProperty.all(const Size.fromWidth(double.maxFinite)),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15)),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColor.primaryColor,
      secondary: AppColor.secondaryColor,
    ),
  );
}

class AppColor {
  static const Color primaryColor = Colors.deepPurple;
  static const Color secondaryColor = Colors.deepPurpleAccent;
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}
