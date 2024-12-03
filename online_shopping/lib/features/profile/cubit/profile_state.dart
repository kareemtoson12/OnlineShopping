part of 'profile_cubit.dart';
// State class

abstract class ProfileState {}

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
