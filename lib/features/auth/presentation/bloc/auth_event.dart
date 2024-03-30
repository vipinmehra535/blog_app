part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthSignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;
  AuthSignUp(
    this.name,
    this.email,
    this.password,
  );
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  AuthLogin(
    this.email,
    this.password,
  );
}
