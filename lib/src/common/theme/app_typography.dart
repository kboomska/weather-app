import 'package:flutter/material.dart';

import 'package:weather_service/src/common/theme/app_colors.dart';

const headerFontFamily = 'Ubuntu';
const defaultFontFamily = 'Roboto';

class AppTypography {
  static const header = TextStyle(
    color: AppColors.typographyHeader,
    fontWeight: FontWeight.w500,
    fontSize: 28,
    height: 32 / 28,
    fontFamily: headerFontFamily,
  );

  static const greyText = TextStyle(
    color: AppColors.typographyGreyText,
    fontWeight: FontWeight.w400,
    fontSize: 15,
    height: 22 / 15,
    fontFamily: defaultFontFamily,
  );
}
