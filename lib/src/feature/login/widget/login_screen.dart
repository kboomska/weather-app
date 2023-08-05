import 'package:flutter/material.dart';

import 'package:weather_service/src/common/theme/app_text_field_style.dart';
import 'package:weather_service/src/common/theme/app_button_style.dart';
import 'package:weather_service/src/common/theme/app_typography.dart';
import 'package:weather_service/src/common/resources/resources.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LoginScreenHeader(),
              _LoginScreenEmailTextField(),
              _LoginScreenPasswordTextField(),
              _LoginScreenLoginButton(),
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
      padding: EdgeInsets.only(top: 24.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Вход',
            style: AppTypography.h1,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Введите данные для входа',
            style: AppTypography.b2,
          ),
        ],
      ),
    );
  }
}

class _LoginScreenEmailTextField extends StatefulWidget {
  const _LoginScreenEmailTextField();

  @override
  State<_LoginScreenEmailTextField> createState() =>
      _LoginScreenEmailTextFieldState();
}

class _LoginScreenEmailTextFieldState
    extends State<_LoginScreenEmailTextField> {
  // final _loginInputController = TextEditingController(text: 'test@mail.ru');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
      child: TextField(
        onChanged: (email) {
          // print(email);
        },
        // controller: _loginInputController,
        style: AppTypography.b1MainText,
        cursorColor: AppColors.primaryRed,
        cursorHeight: 24,
        decoration: AppTextFieldStyle.inputDecoration(labelText: 'Email'),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}

class _LoginScreenPasswordTextField extends StatefulWidget {
  const _LoginScreenPasswordTextField();

  @override
  State<_LoginScreenPasswordTextField> createState() =>
      _LoginScreenPasswordTextFieldState();
}

class _LoginScreenPasswordTextFieldState
    extends State<_LoginScreenPasswordTextField> {
  // final _passwordInputController = TextEditingController(text: 'testpass');
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    Widget suffixWidget = Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          setState(() {
            isObscure = !isObscure;
          });
        },
        child: SizedBox(
          height: 24.0,
          width: 24.0,
          child: Image.asset(
            isObscure ? AppIcons.visibility : AppIcons.visibilityOff,
            color: AppColors.primaryBlue,
          ),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
      child: TextField(
        onChanged: (password) {
          // print(password);
        },
        // controller: _passwordInputController,
        style: AppTypography.b1MainText,
        cursorColor: AppColors.primaryRed,
        cursorHeight: 24,
        obscureText: isObscure,
        decoration: AppTextFieldStyle.inputDecoration(
          labelText: 'Пароль',
          suffixWidget: suffixWidget,
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}

class _LoginScreenLoginButton extends StatelessWidget {
  const _LoginScreenLoginButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: SizedBox.fromSize(
        size: const Size.fromHeight(48.0),
        child: OutlinedButton(
          onPressed: () {},
          style: AppButtonStyle.blueButton,
          child: const Text(
            'Войти',
            style: AppTypography.b1Medium,
          ),
        ),
      ),
    );
  }
}
