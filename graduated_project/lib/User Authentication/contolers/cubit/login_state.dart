part of 'login_cubit.dart';

sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {}

final class GoogleSignInInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class GoogleSignInLoading extends LoginState {}

final class GoogleSignInSuccess extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginError extends LoginState {}
