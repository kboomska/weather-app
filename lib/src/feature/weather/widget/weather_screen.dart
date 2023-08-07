import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_service/src/common/resources/resources.dart';

import 'package:weather_service/src/feature/weather/bloc/weather_forecast_bloc.dart';
import 'package:weather_service/src/feature/login/bloc/login_bloc.dart';
import 'package:weather_service/src/common/theme/app_typography.dart';
import 'package:weather_service/src/common/theme/app_colors.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.black,
              AppColors.weatherScreenBackground,
            ],
            stops: [0.0, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            transform: GradientRotation(2.35619),
            tileMode: TileMode.clamp,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LocationWidget(),
                SizedBox(
                  height: 24,
                ),
                _CurrentWeatherWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LocationWidget extends StatelessWidget {
  const _LocationWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            context.read<LoginBloc>().add(const LoginEvent$Logout());
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: const SizedBox(
            height: 24.0,
            width: 24.0,
            child: Icon(
              Icons.location_on_outlined,
              color: AppColors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        const Text(
          'Архангельск, Россия',
          style: AppTypography.b2Medium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _CurrentWeatherWidget extends StatelessWidget {
  const _CurrentWeatherWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<WeatherForecastBloc>();
    final forecast = bloc.state.forecast;
    if (forecast.isEmpty) {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 180.0,
            width: double.infinity,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Text(
            '--',
            style: AppTypography.temp,
          ),
        ],
      );
    }

    final currentData = forecast[0];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 180.0,
          width: double.infinity,
          child: Image.asset(AppIcons.clearSky),
        ),
        Text(
          '${currentData.temperature}°',
          style: AppTypography.temp,
        ),
        Text(
          currentData.description,
          style: AppTypography.b1Weather,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          'Макс.: ${currentData.tempMax}° Мин: ${currentData.tempMin}°',
          style: AppTypography.b1Weather,
        ),
      ],
    );
  }
}
