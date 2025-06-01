import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/utils/colors.dart';

class ThemeClass {
  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().primaryColor,
    scaffoldBackgroundColor: AppColors.kBgColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.kWhiteColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kBgColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.kFabColor,
    ),
  );
}
