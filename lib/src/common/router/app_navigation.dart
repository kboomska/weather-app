import 'package:flutter/material.dart';

import 'package:weather_service/src/common/router/app_navigation_route_names.dart';
import 'package:weather_service/src/common/widget/app.dart';

abstract interface class IScreenFactory {
  Widget makeLoginScreen();
}

class AppNavigationImpl implements IAppNavigation {
  final IScreenFactory screenFactory;

  const AppNavigationImpl({required this.screenFactory});

  @override
  Map<String, Widget Function(BuildContext)> get routes => {
        AppNavigationRouteNames.login: (_) =>
            screenFactory.makeLoginScreen(),
        // AppNavigationRouteNames.weather: (_) => screenFactory.makeWeatherScreen(),
      };
}
