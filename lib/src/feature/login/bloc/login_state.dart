part of 'package:weather_service/src/feature/login/bloc/login_bloc.dart';

sealed class LoginState extends _$LoginStateBase {
  const LoginState({
    required super.email,
    required super.password,
  });

  const factory LoginState.idle({
    required String email,
    required String password,
    String? error,
  }) = _LoginState$Idle;

  const factory LoginState.processing({
    required String email,
    required String password,
  }) = _LoginState$Processing;

  static const LoginState initialState = LoginState.idle(
    email: '',
    password: '',
  );
}

final class _LoginState$Idle extends LoginState {
  const _LoginState$Idle({
    required super.email,
    required super.password,
    this.error,
  });

  @override
  final String? error;
}

final class _LoginState$Processing extends LoginState {
  const _LoginState$Processing({
    required super.email,
    required super.password,
  });

  @override
  String? get error => null;
}

@immutable
abstract base class _$LoginStateBase {
  final String email;
  final String password;
  abstract final String? error;

  const _$LoginStateBase({
    required this.email,
    required this.password,
  });

  bool get hasError => error != null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _$LoginStateBase &&
        other.email == email &&
        other.password == password &&
        other.error == error;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ error.hashCode;
}
