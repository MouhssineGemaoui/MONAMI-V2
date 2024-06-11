import 'package:flutter/material.dart';
import 'package:monami/core/constant/app_color.dart';

ThemeData themeEnglish = ThemeData(
  textTheme: const TextTheme(
      // ignore: deprecated_member_use
      displayLarge: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.black),
      // ignore: deprecated_member_use
      displayMedium: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.black),
      // ignore: deprecated_member_use
      bodyLarge: TextStyle(height: 2, color: AppColor.grey, fontSize: 14)),
  primarySwatch: Colors.blue,
);
ThemeData themeArabic = ThemeData(
  textTheme: const TextTheme(
      // ignore: deprecated_member_use
      displayLarge: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.black),
      // ignore: deprecated_member_use
      displayMedium: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.black),
      // ignore: deprecated_member_use
      bodyLarge: TextStyle(height: 2, color: AppColor.grey, fontSize: 14)),
  primarySwatch: Colors.blue,
);