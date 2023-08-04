import 'package:flutter/material.dart';

import 'package:weather_service/src/common/router/app_navigation_route_names.dart';

abstract interface class IAppNavigation {
  Route<Object> onGenerateRoute(RouteSettings settings);
  Map<String, Widget Function(BuildContext)> get routes;
}

class App extends StatelessWidget {
  final IAppNavigation navigation;

  const App({super.key, required this.navigation});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Service',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   fontFamily: 'SFProDisplay',
      //   splashColor: Colors.transparent,
      //   highlightColor: Colors.transparent,
      //   appBarTheme: const AppBarTheme(
      //     backgroundColor: AppColors.appBackground,
      //   ),
      // ),
      routes: navigation.routes,
      initialRoute: AppNavigationRouteNames.auth,
    );
  }
}
