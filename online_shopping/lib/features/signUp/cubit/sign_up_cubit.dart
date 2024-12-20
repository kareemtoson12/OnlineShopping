import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shopping/core/services/auth_service.dart';
import 'package:online_shopping/features/cart/models/cart_model.dart';
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
    emit(SignUpLoading()); // Emit a loading state to notify the UI

    try {
      // Create a NewUserModel with the provided user data
      final newUser = NewUserModel(
        id: '', // Placeholder for ID to be generated after registration
        firstName: firstName, // User's first name
        lastName: lastName, // User's last name
        phoneNumber: phoneNumber, // User's phone number
        userName: userName, // Chosen username
        email: email, // User's email address
        cartModel:
            CartModel.empty(), // Initialize an empty cart for the user
      );

      // Register the user using the authentication service
      await authService.registerUserWithEmailandPassword(
        email: email, // Email address for registration
        password: password, // Password for registration
        newUser: newUser, // User data to be saved
      );

      emit(SignUpSucess()); // Emit a success state upon successful registration
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific exceptions and provide user-friendly error messages
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already in use.'; // Email conflict
          break;
        case 'weak-password':
          errorMessage = 'The password provided is too weak.'; // Weak password
          break;
        case 'invalid-email':
          errorMessage = 'The email address is invalid.'; // Invalid email format
          break;
        default:
          errorMessage = 'An error occurred. Please try again.'; // Generic error
      }
      emit(SignUpError(errorMessage)); // Emit an error state with the message
    } catch (e) {
      // Handle any other unexpected exceptions
      emit(SignUpError('An unknown error occurred. Please try again.'));
    }
  }
}
