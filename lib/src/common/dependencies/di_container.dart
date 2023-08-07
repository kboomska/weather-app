import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_service/src/feature/weather/data/api/weather_forecast_network_data_provider.dart';
import 'package:weather_service/src/feature/weather/data/repository/weather_forecast_repository.dart';
import 'package:weather_service/src/feature/login/data/api/login_network_data_provider.dart';
import 'package:weather_service/src/feature/login/data/repository/login_repository.dart';
import 'package:weather_service/src/feature/weather/widget/weather_screen.dart';
import 'package:weather_service/src/feature/login/widget/login_screen.dart';
import 'package:weather_service/src/common/network/network_client.dart';
import 'package:weather_service/src/feature/login/bloc/login_bloc.dart';
import 'package:weather_service/src/common/router/app_navigation.dart';
import 'package:weather_service/src/common/network/http_client.dart';
import 'package:weather_service/src/common/widget/app.dart';
import 'package:weather_service/main.dart';

IAppFactory makeAppFactory() => AppFactoryImpl();

final class AppFactoryImpl implements IAppFactory {
  final _diContainer = DIContainer();

  AppFactoryImpl();

  /// Create [App]
  @override
  Widget makeApp() => App(
        navigation: _diContainer._makeAppNavigation(),
      );
}

final class DIContainer {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  DIContainer();

  /// Create [ScreenFactoryImpl]
  IScreenFactory _makeScreenFactory() => ScreenFactoryImpl(this);

  /// Create [AppNavigationImpl]
  IAppNavigation _makeAppNavigation() => AppNavigationImpl(
        screenFactory: _makeScreenFactory(),
      );

  /// Create [HttpClientImpl]
  IHttpClient _httpClient() => const HttpClientImpl();

  /// Create [NetworkClientImpl]
  INetworkClient _makeNetworkClient() => NetworkClientImpl(
        httpClient: _httpClient(),
      );

  /// Create [LoginNetworkDataProviderImpl]
  ILoginNetworkDataProvider _makeLoginNetworkDataProvider() =>
      LoginNetworkDataProviderImpl(
        networkClient: _makeNetworkClient(),
      );

  /// Create [WeatherForecastNetworkDataProviderImpl]
  IWeatherForecastNetworkDataProvider
      _makeWeatherForecastNetworkDataProvider() =>
          WeatherForecastNetworkDataProviderImpl(
            networkClient: _makeNetworkClient(),
          );

  /// Create [LoginRepositoryImpl]
  ILoginRepository _makeLoginRepository() => LoginRepositoryImpl(
        networkDataProvider: _makeLoginNetworkDataProvider(),
        firebaseAuth: _firebaseAuth,
      );

  /// Create [WeatherForecastRepositoryImpl]
  IWeatherForecastRepository _makeWeatherForecastRepository() =>
      WeatherForecastRepositoryImpl(
        networkDataProvider: _makeWeatherForecastNetworkDataProvider(),
      );

  /// Create [LoginBloc]
  LoginBloc _makeLoginBloc() => LoginBloc(
        loginRepository: _makeLoginRepository(),
      );
}

final class ScreenFactoryImpl implements IScreenFactory {
  final DIContainer diContainer;

  const ScreenFactoryImpl(this.diContainer);

  /// Create [LoginScreen]
  @override
  Widget makeLoginScreen() {
    return BlocProvider(
      create: (_) => diContainer._makeLoginBloc(),
      child: const LoginScreen(),
    );
  }

  /// Create [WeatherScreen]
  @override
  Widget makeWeatherScreen() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => diContainer._makeLoginBloc(),
        ),
      ],
      child: const WeatherScreen(),
    );
  }

  /// Create [LoginScreen] or [WeatherScreen]
  @override
  Widget makeLoginOrWeatherScreen() {
    return StreamBuilder<User?>(
      stream: diContainer._firebaseAuth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return makeWeatherScreen();
        } else {
          return makeLoginScreen();
        }
      },
    );
  }
}
