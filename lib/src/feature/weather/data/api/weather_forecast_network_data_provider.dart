import 'package:weather_service/src/feature/weather/model/weather_forecast.dart';
import 'package:weather_service/src/common/constant/configuration.dart';
import 'package:weather_service/src/common/network/network_client.dart';

abstract interface class IWeatherForecastNetworkDataProvider {
  Future<WeatherForecast> getWeatherForecast({
    required String latitude,
    required String longitude,
  });
}

class WeatherForecastNetworkDataProviderImpl
    implements IWeatherForecastNetworkDataProvider {
  final INetworkClient _networkClient;

  const WeatherForecastNetworkDataProviderImpl({
    required INetworkClient networkClient,
  }) : _networkClient = networkClient;

  @override
  Future<WeatherForecast> getWeatherForecast({
    required String latitude,
    required String longitude,
  }) async {
    final parameters = <String, dynamic>{};

    WeatherForecast parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final jsonResponse = WeatherForecast.fromJson(jsonMap);
      return jsonResponse;
    }

    final result = _networkClient.post(
      Configuration.weatherHost,
      Configuration.weatherForecastUrl,
      parser,
      parameters,
      <String, dynamic>{
        'lat': latitude,
        'lon': longitude,
        'untis': 'metric',
        'cnt': 5,
        'lang': 'ru',
        'key': Configuration.weatherAppId,
      },
    );

    return result;
  }
}