import 'package:weather_service/src/feature/login/data/api/login_network_data_provider.dart';
import 'package:weather_service/src/feature/login/model/user.dart';

abstract interface class ILoginRepository {
  Future<User> login({
    required String email,
    required String password,
  });
}

class LoginRepositoryImpl implements ILoginRepository {
  final ILoginNetworkDataProvider _networkDataProvider;

  const LoginRepositoryImpl({
    required ILoginNetworkDataProvider networkDataProvider,
  }) : _networkDataProvider = networkDataProvider;

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    return _networkDataProvider.login(email: email, password: password);
  }
}
