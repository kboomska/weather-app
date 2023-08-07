part of 'package:weather_service/src/feature/weather/bloc/weather_forecast_bloc.dart';

sealed class WeatherForecastState extends _$WeatherForecastStateBase {
  const WeatherForecastState({
    required super.latitude,
    required super.longitude,
    required super.forecast,
  });

  const factory WeatherForecastState.idle({
    required String latitude,
    required String longitude,
    required List<WeatherPreparedData> forecast,
    String? error,
  }) = _WeatherForecastState$Idle;

  const factory WeatherForecastState.processing({
    required String latitude,
    required String longitude,
    required List<WeatherPreparedData> forecast,
  }) = _WeatherForecastState$Processing;

  static const WeatherForecastState initialState = WeatherForecastState.idle(
    latitude: '',
    longitude: '',
    forecast: <WeatherPreparedData>[],
  );
}

final class _WeatherForecastState$Idle extends WeatherForecastState {
  const _WeatherForecastState$Idle({
    required super.latitude,
    required super.longitude,
    required super.forecast,
    this.error,
  });

  @override
  final String? error;
}

final class _WeatherForecastState$Processing extends WeatherForecastState {
  const _WeatherForecastState$Processing({
    required super.latitude,
    required super.longitude,
    required super.forecast,
  });

  @override
  String? get error => null;
}

@immutable
abstract base class _$WeatherForecastStateBase {
  final String latitude;
  final String longitude;
  final List<WeatherPreparedData> forecast;
  abstract final String? error;

  const _$WeatherForecastStateBase({
    required this.latitude,
    required this.longitude,
    required this.forecast,
  });

  bool get hasError => error != null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _$WeatherForecastStateBase &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        listEquals(other.forecast, forecast) &&
        other.error == error;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^
        longitude.hashCode ^
        forecast.hashCode ^
        error.hashCode;
  }
}
