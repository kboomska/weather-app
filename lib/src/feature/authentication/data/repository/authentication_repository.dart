import 'package:weather_service/src/feature/authentication/data/api/authentication_network_data_provider.dart';

abstract interface class IAuthenticationRepository {}

class AuthenticationRepositoryImpl implements IAuthenticationRepository {
  final IAuthenticationNetworkDataProvider _networkDataProvider;

  const AuthenticationRepositoryImpl({
    required IAuthenticationNetworkDataProvider networkDataProvider,
  }) : _networkDataProvider = networkDataProvider;
}
