import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shopping/core/services/auth_service.dart';
import 'package:online_shopping/features/signUp/models/new_user_model.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.authService) : super(SignUpIntial());

  final AuthService authService;

  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String userName,
  }) async {
    emit(SignUpLoading());

    try {
      // Create a NewUserModel with provided data
      final newUser = NewUserModel(
        id: '',
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        userName: userName,
        email: email,
      );

      // Register user and save data
      await authService.registerUserWithEmailandPassword(
        email: email,
        password: password,
        newUser: newUser,
      );

      emit(SignUpSucess());
    } on FirebaseAuthException catch (e) {
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
      emit(SignUpError('An unknown error occurred. Please try again.'));
    }
  }
}
