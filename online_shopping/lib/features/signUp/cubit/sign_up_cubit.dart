import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shopping/core/services/auth_service.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.authService) : super(SignUpIntial());

  final AuthService authService;

  Future<void> signUp(String email, String password) async {
    emit(SignUpLoading());

    try {
      // Await the async function
      await authService.registerUserWithEmailandPassword(email, password);
      emit(SignUpSucess());
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already in use.';
          break;
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is invalid.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      emit(SignUpError(errorMessage));
    } catch (e) {
      // Catch any other exceptions
      emit(SignUpError('An unknown error occurred. Please try again.'));
    }
  }
}
