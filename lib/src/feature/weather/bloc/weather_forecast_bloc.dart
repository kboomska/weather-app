import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_service/src/common/resources/resources.dart';

import 'package:weather_service/src/feature/weather/data/repository/weather_forecast_repository.dart';
import 'package:weather_service/src/feature/weather/model/weather_prepared_data.dart';
import 'package:weather_service/src/common/network/network_client_exception.dart';
import 'package:weather_service/src/feature/weather/model/weather_forecast.dart';

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
      forecast: state.forecast,
    ));

    String? error;
    List<WeatherPreparedData> forecast = <WeatherPreparedData>[];
    try {
      final rawForecast = await _weatherForecastRepository
          .getWeatherForecast(
            latitude: event.latitude,
            longitude: event.longitude,
          )
          .timeout(const Duration(seconds: 5));
      forecast.addAll(parseForecast(rawForecast));
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
            latitude: event.latitude,
            longitude: event.longitude,
            forecast: forecast,
            error: error),
      );
    }
  }

  List<WeatherPreparedData> parseForecast(WeatherForecast rawForecast) {
    List<WeatherPreparedData> result = [];
    final listOfRawForecast = rawForecast.list;
    if (listOfRawForecast != null) {
      for (WheatherList v in listOfRawForecast) {
        final dateTime = DateTime.fromMillisecondsSinceEpoch(
          (v.dt ?? 1691431200) * 1000,
        );

        result.add(
          WeatherPreparedData(
            date: DateFormat.MMMd('RU_ru').format(dateTime),
            time: DateFormat.Hm('RU_ru').format(dateTime),
            temperature: v.main?.temp?.round().toString() ?? '--',
            tempMin: v.main?.tempMin?.round().toString() ?? '',
            tempMax: v.main?.tempMax?.round().toString() ?? '',
            description: setDescription(v.weather?[0].icon ?? ''),
            icon: setIcon(v.weather?[0].icon ?? ''),
            windSpeed: v.wind?.speed?.round().toString() ?? '',
            windDirection: v.wind?.deg.toString() ?? '',
            humidity: v.main?.humidity?.round().toString() ?? '',
            humidityDescription: (v.main?.humidity?.round() ?? 0) <= 50
                ? 'Низкая влажность'
                : 'Высокая влажность',
          ),
        );
      }
    }
    return result;
  }

  String setDescription(String rawIcon) {
    switch (rawIcon) {
      case '01d':
        return 'Ясно';
      case '04d':
        return 'Облачно';
      case '09d':
        return 'Ливень';
      case '10d':
        return 'Дождь';
      case '11d':
        return 'Гроза';
      case '13d':
        return 'Снег';
      default:
        return 'Переменная облачность';
    }
  }

  String setIcon(String rawIcon) {
    switch (rawIcon) {
      case '01d':
        return AppIcons.clearSky;
      case '04d':
        return AppIcons.scarettedClouds;
      case '09d':
        return AppIcons.showerRain;
      case '10d':
        return AppIcons.rain;
      case '11d':
        return AppIcons.thunderstorm;
      case '13d':
        return AppIcons.snow;
      default:
        return AppIcons.clearSky;
    }
  }
}
