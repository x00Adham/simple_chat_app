part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure(this.errorMessage);
}

final class AuthSuccess extends AuthState {}

final class LogoutSuccess extends AuthState {}

final class Logoutfailure extends AuthState {}
