import 'package:weather_service/src/feature/login/data/api/login_network_data_provider.dart';

abstract interface class ILoginRepository {}

class LoginRepositoryImpl implements ILoginRepository {
  final ILoginNetworkDataProvider _networkDataProvider;

  const LoginRepositoryImpl({
    required ILoginNetworkDataProvider networkDataProvider,
  }) : _networkDataProvider = networkDataProvider;
}
