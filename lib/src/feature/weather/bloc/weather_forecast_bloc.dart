import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:weather_service/src/feature/weather/data/repository/weather_forecast_repository.dart';
import 'package:weather_service/src/common/network/network_client_exception.dart';

part 'package:weather_service/src/feature/weather/bloc/weather_forecast_state.dart';
part 'package:weather_service/src/feature/weather/bloc/weather_forecast_event.dart';

class WeatherForecastBloc
    extends Bloc<WeatherForecastEvent, WeatherForecastState> {
  final IWeatherForecastRepository _weatherForecastRepository;
  WeatherForecastBloc({
    required IWeatherForecastRepository weatherForecastRepository,
    final WeatherForecastState? initialState,
  })  : _weatherForecastRepository = weatherForecastRepository,
        super(initialState ?? WeatherForecastState.initialState) {
    on<WeatherForecastEvent>(
      (event, emit) async {
        if (event is WeatherForecastEvent$CoordinatesChanged) {
          await _onWeatherForecastEvent$CoordinatesChanged(event, emit);
        }
      },
      transformer: sequential(),
    );

    add(
      const WeatherForecastEvent$CoordinatesChanged(
        latitude: '55.7512',
        longitude: '37.6184',
      ),
    );
  }

  Future<void> _onWeatherForecastEvent$CoordinatesChanged(
    WeatherForecastEvent$CoordinatesChanged event,
    Emitter<WeatherForecastState> emit,
  ) async {
    if (state is _WeatherForecastState$Processing) return;

    emit(WeatherForecastState.processing(
      latitude: state.latitude,
      longitude: state.longitude,
    ));

    String? error;
    try {
      final forecast = await _weatherForecastRepository
          .getWeatherForecast(
            latitude: event.latitude,
            longitude: event.longitude,
          )
          .timeout(const Duration(seconds: 5));
    } on TimeoutException {
      error =
          'Превышено время ожидания ответа от сервера. Повторите попытку позднее';
    } on NetworkClientException catch (e) {
      switch (e.type) {
        case NetworkClientExceptionType.network:
          error = 'Сервер не доступен. Проверьте подключение к сети интернет';
        case NetworkClientExceptionType.other:
          error = 'Произошла ошибка. Попробуйте еще раз';
      }
    } catch (_) {
      error = 'Неизвестная ошибка, повторите попытку';
      rethrow;
    } finally {
      emit(
        WeatherForecastState.idle(
            latitude: state.latitude, longitude: state.longitude, error: error),
      );
    }
  }
}
