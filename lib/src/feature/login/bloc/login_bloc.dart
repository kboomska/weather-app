import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:weather_service/src/feature/login/data/repository/login_repository.dart';
import 'package:weather_service/src/common/network/network_client_exception.dart';

part 'package:weather_service/src/feature/login/bloc/login_event.dart';
part 'package:weather_service/src/feature/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ILoginRepository _loginRepository;

  LoginBloc({
    required ILoginRepository loginRepository,
    final LoginState? initialState,
  })  : _loginRepository = loginRepository,
        super(initialState ?? LoginState.initialState) {
    on<LoginEvent>(
      (event, emit) async {
        if (event is LoginEvent$EmailChanged) {
          await _onLoginEvent$EmailChanged(event, emit);
        } else if (event is LoginEvent$PasswordChanged) {
          await _onLoginEvent$PasswordChanged(event, emit);
        } else if (event is LoginEvent$OnSubmitted) {
          await _onLoginEvent$OnSubmitted(event, emit);
        } else if (event is LoginEvent$Logout) {
          await _onLoginEvent$Logout(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  Future<void> _onLoginEvent$EmailChanged(
    LoginEvent$EmailChanged event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.idle(email: event.email, password: state.password));
  }

  Future<void> _onLoginEvent$PasswordChanged(
    LoginEvent$PasswordChanged event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.idle(email: state.email, password: event.password));
  }

  Future<void> _onLoginEvent$OnSubmitted(
    LoginEvent$OnSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state is _LoginState$Processing) return;

    emit(LoginState.processing(email: state.email, password: state.password));

    String? error;
    try {
      await _loginRepository
          .logInWithEmailAndPassword(
            email: state.email,
            password: state.password,
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
        LoginState.idle(
            email: state.email, password: state.password, error: error),
      );
    }
  }

  Future<void> _onLoginEvent$Logout(
    LoginEvent$Logout event,
    Emitter<LoginState> emit,
  ) async {
    if (state is _LoginState$Processing) return;

    emit(LoginState.processing(email: state.email, password: state.password));

    String? error;
    try {
      await _loginRepository.logOut().timeout(const Duration(seconds: 5));
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
        LoginState.idle(email: '', password: '', error: error),
      );
    }
  }
}
