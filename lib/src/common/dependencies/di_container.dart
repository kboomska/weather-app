import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_service/src/feature/authentication/data/api/authentication_network_data_provider.dart';
import 'package:weather_service/src/feature/authentication/data/repository/authentication_repository.dart';
import 'package:weather_service/src/feature/authentication/widget/authentication_screen.dart';
import 'package:weather_service/src/common/network/network_client.dart';
import 'package:weather_service/src/common/router/app_navigation.dart';
import 'package:weather_service/src/common/network/http_client.dart';
import 'package:weather_service/src/common/widget/app.dart';
import 'package:weather_service/main.dart';

IAppFactory makeAppFactory() => const AppFactoryImpl();

final class AppFactoryImpl implements IAppFactory {
  final _diContainer = const DIContainer();

  const AppFactoryImpl();

  /// Create [App]
  @override
  Widget makeApp() => App(
        navigation: _diContainer._makeAppNavigation(),
      );
}

final class DIContainer {
  const DIContainer();

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

  /// Create [AuthenticationNetworkDataProviderImpl]
  IAuthenticationNetworkDataProvider _makeAuthenticationNetworkDataProvider() =>
      AuthenticationNetworkDataProviderImpl(
        networkClient: _makeNetworkClient(),
      );

  /// Create [AuthenticationRepositoryImpl]
  IAuthenticationRepository _makeAuthenticationRepository() =>
      AuthenticationRepositoryImpl(
        networkDataProvider: _makeAuthenticationNetworkDataProvider(),
      );

  /// Create [AuthenticationBloc]
  // AuthenticationBloc _makeAuthenticationBloc() => AuthenticationBloc(
  //       authenticationRepository: _makeAuthenticationRepository(),
  //     );
}

final class ScreenFactoryImpl implements IScreenFactory {
  final DIContainer diContainer;

  const ScreenFactoryImpl(this.diContainer);

  // @override
  // Widget makeAuthenticationScreen() {
  //   return BlocProvider(
  //     create: (_) => diContainer._makeAuthenticationBloc(),
  //     child: const AuthenticationScreen(),
  //   );
  // }

  @override
  Widget makeAuthenticationScreen() {
    return const AuthenticationScreen();
  }
}
