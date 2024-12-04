import 'package:bloc/bloc.dart';
import 'package:online_shopping/core/services/auth_service.dart';

import 'package:online_shopping/features/signUp/models/new_user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthService authService;

  ProfileCubit(this.authService) : super(ProfileInitial());

  Future<void> fetchUserProfile() async {
    emit(ProfileLoading());
    try {
      NewUserModel? user = await authService.getUserById();
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError('User not found'));
      }
    } catch (e) {
      emit(ProfileError('Failed to load user data: $e'));
    }
  }

  Future<void> logout() async {
    try {
      await authService.logUserOut();
      emit(LogoutSucess());
    } catch (e) {
      emit(LogoutError('Logout failed: $e'));
    }
  }
}
