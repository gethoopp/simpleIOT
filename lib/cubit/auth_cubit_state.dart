part of 'auth_cubit_cubit.dart';

sealed class AuthCubitState {}

final class AuthCubitInitial extends AuthCubitState {}

final class AuthSucces extends AuthCubitState {
  User? user;

  AuthSucces(this.user);
}

final class AuthErr extends AuthCubitState {}
