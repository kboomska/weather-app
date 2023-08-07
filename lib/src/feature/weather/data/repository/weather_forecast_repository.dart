import 'package:weather_service/src/feature/weather/data/api/weather_forecast_network_data_provider.dart';
import 'package:weather_service/src/feature/weather/model/weather_forecast.dart';

abstract interface class IWeatherForecastRepository {
  Future<WeatherForecast> getWeatherForecast({
    required String latitude,
    required String longitude,
  });
}

class WeatherForecastRepositoryImpl implements IWeatherForecastRepository {
  final IWeatherForecastNetworkDataProvider _networkDataProvider;

  const WeatherForecastRepositoryImpl({
    required IWeatherForecastNetworkDataProvider networkDataProvider,
  }) : _networkDataProvider = networkDataProvider;

  @override
  Future<WeatherForecast> getWeatherForecast({
    required String latitude,
    required String longitude,
  }) async {
    return _networkDataProvider.getWeatherForecast(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
