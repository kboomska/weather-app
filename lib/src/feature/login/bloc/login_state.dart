import 'package:meta/meta.dart';

import 'package:weather_service/src/feature/login/model/user.dart';

sealed class LoginState extends _$LoginStateBase {
  const LoginState({required super.user});

  const factory LoginState.idle({
    required User user,
    String? error,
  }) = _LoginState$Idle;

  const factory LoginState.processing({
    required User user,
  }) = _LoginState$Processing;

  static const LoginState initialState = LoginState.idle(
    user: User(
        idToken: null,
        email: null,
        refreshToken: null,
        expiresIn: null,
        localId: null,
        registered: null,
        displayName: null),
    error: null,
  );
}

final class _LoginState$Idle extends LoginState {
  const _LoginState$Idle({required super.user, this.error});

  @override
  final String? error;
}

final class _LoginState$Processing extends LoginState {
  const _LoginState$Processing({required super.user});

  @override
  String? get error => null;
}

@immutable
abstract base class _$LoginStateBase {
  final User user;
  abstract final String? error;

  const _$LoginStateBase({
    required this.user,
  });

  bool get hasError => error != null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _$LoginStateBase &&
        other.user == user &&
        other.error == error;
  }

  @override
  int get hashCode => user.hashCode ^ error.hashCode;
}
