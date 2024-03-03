part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class changstat extends AuthState {}

final class createAcunte extends AuthState {}

final class login extends AuthState {}

final class Filur extends AuthState {
  String ErrorMessages;
  Filur(this.ErrorMessages);
}

final class success extends AuthState {}
