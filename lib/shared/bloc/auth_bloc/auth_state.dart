part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  UserModel? profile;

  AuthState({this.profile});
}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {
  AuthLoadingState({UserModel? user}) : super(profile: user);
}

class AuthError extends AuthState {
  final String? message;

  AuthError({UserModel? user, this.message}) : super(profile: user);
}

class UnauthenticatedState extends AuthState {}

class AuthSuccess extends AuthState {
  final String? message;

  AuthSuccess({UserModel? user, this.message}) : super(profile: user);
}
