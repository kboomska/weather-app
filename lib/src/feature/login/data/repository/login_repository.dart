import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:weather_service/src/feature/login/data/api/login_network_data_provider.dart';
import 'package:weather_service/src/feature/login/model/user.dart';

abstract interface class ILoginRepository {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class LoginRepositoryImpl implements ILoginRepository {
  final ILoginNetworkDataProvider _networkDataProvider;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  const LoginRepositoryImpl({
    required ILoginNetworkDataProvider networkDataProvider,
    required firebase_auth.FirebaseAuth firebaseAuth,
  })  : _networkDataProvider = networkDataProvider,
        _firebaseAuth = firebaseAuth;

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    return _networkDataProvider.login(email: email, password: password);
  }

  @override
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
