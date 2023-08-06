part of 'package:weather_service/src/feature/login/bloc/login_bloc.dart';

sealed class LoginEvent {
  const LoginEvent();
}

final class LoginEvent$EmailChanged extends LoginEvent {
  final String email;

  const LoginEvent$EmailChanged({required this.email});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginEvent$EmailChanged && other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}

final class LoginEvent$PasswordChanged extends LoginEvent {
  final String password;

  const LoginEvent$PasswordChanged({required this.password});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginEvent$PasswordChanged && other.password == password;
  }

  @override
  int get hashCode => password.hashCode;
}

final class LoginEvent$OnSubmitted extends LoginEvent {
  const LoginEvent$OnSubmitted();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginEvent$OnSubmitted;
  }

  @override
  int get hashCode => 0;
}

final class LoginEvent$Logout extends LoginEvent {
  const LoginEvent$Logout();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginEvent$Logout;
  }

  @override
  int get hashCode => 0;
}
