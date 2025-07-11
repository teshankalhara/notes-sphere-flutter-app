import 'package:flutter/material.dart';

class AppColors {
  //primary colors
  static const Color kFabColor = Color.fromARGB(255, 204, 17, 237);
  static const Color kBgColor = Color(0xff202326);
  static const Color kCardColor = Color(0xff2F3235);
  static const Color kWhiteColor = Color.fromARGB(255, 255, 255, 255);

  //gradient colors
  static const int gradientStart = 0XFF01F0FF;
  static const int gradientEnd = 0XFF4441ED;
  LinearGradient kPrimaryGradient = const LinearGradient(
    colors: <Color>[Color(gradientStart), Color(gradientEnd)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
