part of 'package:weather_service/src/feature/weather/bloc/weather_forecast_bloc.dart';

sealed class WeatherForecastState extends _$WeatherForecastStateBase {
  const WeatherForecastState({
    required super.latitude,
    required super.longitude,
  });

  const factory WeatherForecastState.idle({
    required String latitude,
    required String longitude,
    String? error,
  }) = _WeatherForecastState$Idle;

  const factory WeatherForecastState.processing({
    required String latitude,
    required String longitude,
  }) = _WeatherForecastState$Processing;

  static const WeatherForecastState initialState = WeatherForecastState.idle(
    latitude: '',
    longitude: '',
  );
}

final class _WeatherForecastState$Idle extends WeatherForecastState {
  const _WeatherForecastState$Idle({
    required super.latitude,
    required super.longitude,
    this.error,
  });

  @override
  final String? error;
}

final class _WeatherForecastState$Processing extends WeatherForecastState {
  const _WeatherForecastState$Processing({
    required super.latitude,
    required super.longitude,
  });

  @override
  String? get error => null;
}

@immutable
abstract base class _$WeatherForecastStateBase {
  final String latitude;
  final String longitude;
  abstract final String? error;

  const _$WeatherForecastStateBase({
    required this.latitude,
    required this.longitude,
  });

  bool get hasError => error != null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _$WeatherForecastStateBase &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.error == error;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode ^ error.hashCode;
}
