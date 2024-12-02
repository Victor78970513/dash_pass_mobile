part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String username;
  final String password;
  final int carnet;
  final int phone;

  AuthSignUpEvent({
    required this.email,
    required this.username,
    required this.password,
    required this.carnet,
    required this.phone,
  });
}

final class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent({required this.email, required this.password});
}

final class AuthUpdateEvent extends AuthEvent {
  final String name;
  final String uid;

  AuthUpdateEvent({required this.name, required this.uid});
}

final class AuthLogOut extends AuthEvent {}

final class IsUserLoggedIn extends AuthEvent {}
