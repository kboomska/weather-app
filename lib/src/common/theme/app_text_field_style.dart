import 'package:flutter/material.dart';

import 'package:weather_service/src/common/theme/app_typography.dart';
import 'package:weather_service/src/common/theme/app_colors.dart';

abstract final class AppTextFieldStyle {
  static inputDecoration({required String labelText, Widget? suffixWidget}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: AppTypography.b1,
      floatingLabelStyle: AppTypography.b2MainText,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: AppColors.underlineInputBorder,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: AppColors.primaryBlue,
        ),
      ),
      constraints: BoxConstraints.tight(const Size.fromHeight(64.0)),
      suffixIcon: suffixWidget,
      suffixIconConstraints: BoxConstraints.tight(
        const Size(32, 24),
      ),
    );
  }
}
