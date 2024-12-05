part of 'admin_login_cubit.dart';

abstract class AdminLoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminLoginInitial extends AdminLoginState {}

class AdminLoginLoading extends AdminLoginState {}

class AdminLoginSuccess extends AdminLoginState {}

class AdminLoginError extends AdminLoginState {
  final String message;

  AdminLoginError(this.message);

  @override
  List<Object?> get props => [message];
}
