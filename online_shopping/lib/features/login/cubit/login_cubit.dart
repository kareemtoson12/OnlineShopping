import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shopping/core/services/auth_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authService) : super(LoginInitial());

  final AuthService authService;

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      // Await the sign-in operation
      await authService.signInWithEmailandPassword(email, password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address. Please check your input.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again later.';
      }
      emit(LoginError(errorMessage));
    } catch (e) {
      emit(LoginError('An unknown error occurred. Please try again.'));
    }
  }
}
