part of 'profile_cubit.dart';
// State class

abstract class ProfileState {}

//Profile state
class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final NewUserModel user;

  ProfileLoaded(this.user);
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}

//LOGOUT STATS
class LogoutSucess extends ProfileState {}

class LogoutError extends ProfileState {
  final String error;

  LogoutError(this.error);
}
