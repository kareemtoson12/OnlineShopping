part of 'sign_up_cubit.dart';

abstract class SignUpState {}

class SignUpIntial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSucess extends SignUpState {}

class SignUpError extends SignUpState {
  final String message;
  SignUpError(this.message);
}
