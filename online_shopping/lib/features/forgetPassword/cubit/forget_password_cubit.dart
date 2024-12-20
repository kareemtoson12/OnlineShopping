import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shopping/core/services/auth_service.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(
    this.authService,
  ) : super(ForgetPasswordIntial()); // Initial state of the cubit

  final AuthService authService; // Dependency injection for AuthService

  /// Sends a password reset email to the provided email address.
  /// Validates the email format before sending the request and handles
  /// both Firebase-specific and general errors gracefully.
  Future<void> sendPasswordResetEmail(String email) async {
    emit(ForgetPasswordLoading()); // Emit loading state while processing

    try {
      // Validate the email input
      if (email.isEmpty) {
        // Emit error state if the email field is empty
        throw Exception('Email field cannot be empty.');
      }

      // Use a regular expression to validate email format
      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        // Emit error state for invalid email format
        throw Exception('Please enter a valid email address.');
      }

      // Attempt to send a password reset email via AuthService
      await authService.forgetPassword(email);

      emit(ForgetPasswordSucess()); // Emit success state if operation succeeds
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific exceptions
      String errorMessage;
      switch (e.code) {
        case 'user-not-found': // No user exists with the provided email
          errorMessage = 'No user found with this email.';
          break;
        case 'invalid-email': // The email format is invalid
          errorMessage = 'The email address is not valid.';
          break;
        case 'network-request-failed': // Network issues
          errorMessage = 'Please check your internet connection.';
          break;
        default: // Catch all other Firebase errors
          errorMessage = 'An error occurred. Please try again.';
      }

      emit(ForgetPasswordError(errorMessage)); // Emit error state with message
    } catch (e) {
      // Handle general exceptions
      emit(ForgetPasswordError(e.toString())); // Emit error state with exception message
    }
  }
}
