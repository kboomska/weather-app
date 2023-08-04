import 'package:weather_service/src/common/network/network_client.dart';

abstract interface class ILoginNetworkDataProvider {}

class LoginNetworkDataProviderImpl
    implements ILoginNetworkDataProvider {
  final INetworkClient _networkClient;

  const LoginNetworkDataProviderImpl({
    required INetworkClient networkClient,
  }) : _networkClient = networkClient;
}
