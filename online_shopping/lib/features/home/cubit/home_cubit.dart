import 'package:bloc/bloc.dart';
import 'package:online_shopping/core/services/auth_service.dart';
import 'package:online_shopping/features/home/models/category_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.authService) : super(HomeIntial());

  final AuthService authService;

  // Store loaded categories
  List<CategoryModel> categories = [];

  // Fetch all categories
  Future<void> fetchCategories() async {
    emit(HomeCategoriesLoading());
    try {
      final categories = await authService.getAllCategories();
      emit(HomeCategoriesSuccess(categories));
    } catch (e) {
      emit(HomeCategoriesError('Failed to load categories: $e'));
    }
  }
}
