import 'package:flutter/material.dart';

import 'package:weather_service/src/common/theme/app_typography.dart';
import 'package:weather_service/src/common/theme/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.loginScreenBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            children: [
              _LoginScreenHeader(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginScreenHeader extends StatelessWidget {
  const _LoginScreenHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Вход',
            style: AppTypography.header,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Введите данные для входа',
            style: AppTypography.greyText,
          ),
        ],
      ),
    );
  }
}
