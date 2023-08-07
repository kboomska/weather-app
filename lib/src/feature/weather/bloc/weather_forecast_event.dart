part of 'package:weather_service/src/feature/weather/bloc/weather_forecast_bloc.dart';

sealed class WeatherForecastEvent {
  const WeatherForecastEvent();
}

final class WeatherForecastEvent$CoordinatesChanged
    extends WeatherForecastEvent {
  final String latitude;
  final String longitude;

  const WeatherForecastEvent$CoordinatesChanged({
    required this.latitude,
    required this.longitude,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherForecastEvent$CoordinatesChanged &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}
