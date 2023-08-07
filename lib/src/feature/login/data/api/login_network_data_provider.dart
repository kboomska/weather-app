import 'package:weather_service/src/common/constant/configuration.dart';
import 'package:weather_service/src/common/network/network_client.dart';
import 'package:weather_service/src/feature/login/model/user.dart';

abstract interface class ILoginNetworkDataProvider {
  Future<User> login({
    required String email,
    required String password,
  });
}

class LoginNetworkDataProviderImpl implements ILoginNetworkDataProvider {
  final INetworkClient _networkClient;

  const LoginNetworkDataProviderImpl({
    required INetworkClient networkClient,
  }) : _networkClient = networkClient;

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    final parameters = <String, dynamic>{
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    User parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final jsonResponse = User.fromJson(jsonMap);
      return jsonResponse;
    }

    final result = _networkClient.post(
      Configuration.authHost,
      Configuration.authSignInUrl,
      parser,
      parameters,
      <String, dynamic>{'key': Configuration.authApiKey},
    );

    return result;
  }
}
