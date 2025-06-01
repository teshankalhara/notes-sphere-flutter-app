import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/utils/colors.dart';

class AppTextStyles {
  static const TextStyle appTitle = TextStyle(
    fontSize: 28,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle appSubtitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.kWhiteColor,
  );

  static const TextStyle appDescription = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.kWhiteColor,
  );

  static const TextStyle appDescriptionSmall = TextStyle(
    fontSize: 14,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle appBody = TextStyle(color: Colors.white, fontSize: 16);

  static const TextStyle appButton = TextStyle(
    fontSize: 16,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.bold,
  );
}
