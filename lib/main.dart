import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_service/src/common/dependencies/di_container.dart';
import 'package:weather_service/src/common/bloc/app_bloc_observer.dart';

abstract interface class IAppFactory {
  Widget makeApp();
}

final appFactory = makeAppFactory();

void main() {
  Bloc.observer = AppBlocObserver();

  final app = appFactory.makeApp();
  runApp(app);
}
