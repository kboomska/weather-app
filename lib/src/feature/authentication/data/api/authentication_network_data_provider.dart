import 'package:weather_service/src/common/network/network_client.dart';

abstract interface class IAuthenticationNetworkDataProvider {}

class AuthenticationNetworkDataProviderImpl
    implements IAuthenticationNetworkDataProvider {
  final INetworkClient _networkClient;

  const AuthenticationNetworkDataProviderImpl({
    required INetworkClient networkClient,
  }) : _networkClient = networkClient;
}
