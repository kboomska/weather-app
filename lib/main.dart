import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_service/src/common/dependencies/di_container.dart';
import 'package:weather_service/src/common/bloc/app_bloc_observer.dart';
import 'package:weather_service/firebase_options.dart';

abstract interface class IAppFactory {
  Widget makeApp();
}

final appFactory = makeAppFactory();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = AppBlocObserver();

  final app = appFactory.makeApp();
  runApp(app);
}
