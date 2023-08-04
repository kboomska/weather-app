import 'package:flutter/material.dart';

import 'package:weather_service/src/common/router/app_navigation_route_names.dart';
import 'package:weather_service/src/common/widget/app.dart';

abstract interface class IScreenFactory {
  Widget makeAuthenticationScreen();
}

class AppNavigationImpl implements IAppNavigation {
  final IScreenFactory screenFactory;

  const AppNavigationImpl({required this.screenFactory});

  @override
  Map<String, Widget Function(BuildContext)> get routes => {
        // AppNavigationRouteNames.home: (_) => screenFactory.makeHomeScreen(),
        AppNavigationRouteNames.auth: (_) =>
            screenFactory.makeAuthenticationScreen(),
      };
  @override
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case AppNavigationRouteNames.category:
      //   final configuration = settings.arguments as CategoryScreenConfiguration;
      //   return MaterialPageRoute(
      //     builder: (_) => screenFactory.makeCategoryScreen(configuration),
      //   );
      default:
        return MaterialPageRoute(
          builder: (_) => screenFactory.makeAuthenticationScreen(),
        );
    }
  }
}
