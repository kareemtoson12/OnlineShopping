import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shopping/core/services/auth_service.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(
    this.authService,
  ) : super(ForgetPasswordIntial());

  final AuthService authService;

  Future<void> sendPasswordResetEmail(String email) async {
    emit(ForgetPasswordLoading());
    try {
      // Validate the email format before sending the request
      if (email.isEmpty) {
        throw Exception('Email field cannot be empty.');
      }
      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        throw Exception('Please enter a valid email address.');
      }

      // Attempt to send a password reset email
      await authService.forgetPassword(email);

      emit(ForgetPasswordSucess());
    } on FirebaseAuthException catch (e) {
      // Firebase-specific errors
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'network-request-failed':
          errorMessage = 'Please check your internet connection.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      emit(ForgetPasswordError(errorMessage));
    } catch (e) {
      // General exceptions
      emit(ForgetPasswordError(e.toString()));
    }
  }
}
