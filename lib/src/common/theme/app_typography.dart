import 'package:flutter/material.dart';

import 'package:weather_service/src/common/theme/app_colors.dart';

const headerFontFamily = 'Ubuntu';
const defaultFontFamily = 'Roboto';

abstract final class AppTypography {
  static const h1 = TextStyle(
    color: AppColors.typographyHeader,
    fontWeight: FontWeight.w500,
    fontSize: 28,
    height: 32 / 28,
    fontFamily: headerFontFamily,
  );

  static const b1 = TextStyle(
    color: AppColors.typographyGreyText,
    fontWeight: FontWeight.w400,
    fontSize: 17,
    height: 24 / 17,
    fontFamily: defaultFontFamily,
  );

  static const b1Weather = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w400,
    fontSize: 17,
    height: 24 / 17,
    fontFamily: defaultFontFamily,
  );

  static const b1MainText = TextStyle(
    color: AppColors.typographyHeader,
    fontWeight: FontWeight.w400,
    fontSize: 17,
    height: 24 / 17,
    fontFamily: defaultFontFamily,
  );

  static const b1Medium = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 17,
    height: 24 / 17,
    fontFamily: defaultFontFamily,
  );

  static const b2 = TextStyle(
    color: AppColors.typographyGreyText,
    fontWeight: FontWeight.w400,
    fontSize: 15,
    height: 22 / 15,
    fontFamily: defaultFontFamily,
  );

  static const b2MainText = TextStyle(
    color: AppColors.typographyGreyText,
    fontWeight: FontWeight.w400,
    fontSize: 15,
    height: 22 / 15,
    fontFamily: defaultFontFamily,
  );

  static const b2Medium = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 15,
    height: 22 / 15,
    fontFamily: defaultFontFamily,
  );

  static const temp = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 64,
    height: 72 / 64,
    fontFamily: headerFontFamily,
  );
}
