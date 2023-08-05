import 'package:flutter/material.dart';

import 'package:weather_service/src/common/theme/app_colors.dart';

abstract final class AppButtonStyle {
  static final ButtonStyle blueButton = ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll(
      AppColors.primaryBlue,
    ),
    minimumSize: const MaterialStatePropertyAll(
      Size.fromHeight(48),
    ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
    ),
    side: const MaterialStatePropertyAll(BorderSide.none),
  );
}
