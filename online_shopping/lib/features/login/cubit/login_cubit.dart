import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shopping/core/services/auth_service.dart';

// Part directive includes the login_state.dart file, which contains the LoginState class definitions
part 'login_state.dart';

// Cubit to handle login functionality and manage login states
class LoginCubit extends Cubit<LoginState> {
  // Constructor initializes the LoginCubit with an instance of AuthService
  LoginCubit(this.authService) : super(LoginInitial());

  final AuthService authService; // Dependency to perform authentication operations

  // Method to handle user login
  Future<void> login(String email, String password) async {
    emit(LoginLoading()); // Emit loading state while processing login
    try {
      // Attempt to sign in with the provided email and password using AuthService
      await authService.signInWithEmailandPassword(email, password);
      emit(LoginSuccess()); // Emit success state if login is successful
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors during sign-in
      String errorMessage;
      switch (e.code) {
        case 'user-not-found': // User does not exist
          errorMessage = 'No user found for this email.';
          break;
        case 'wrong-password': // Incorrect password
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email': // Malformed email input
          errorMessage = 'Invalid email address. Please check your input.';
          break;
        default: // Catch-all for other FirebaseAuth exceptions
          errorMessage = 'An error occurred. Please try again later.';
      }
      emit(LoginError(errorMessage)); // Emit error state with a descriptive message
    } catch (e) {
      // Handle general (non-Firebase) errors
      emit(LoginError('An unknown error occurred. Please try again.'));
    }
  }
}
