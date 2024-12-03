part of 'forget_password_cubit.dart';

abstract class ForgetPasswordState {}

class ForgetPasswordIntial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSucess extends ForgetPasswordState {}

class ForgetPasswordError extends ForgetPasswordState {
  final String message;
  ForgetPasswordError(this.message);
}
