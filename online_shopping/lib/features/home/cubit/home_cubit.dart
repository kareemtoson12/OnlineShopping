import 'package:bloc/bloc.dart';
import 'package:online_shopping/core/services/auth_service.dart';
import 'package:online_shopping/features/home/models/category_model.dart';
import 'package:online_shopping/features/product/models/product_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.authService) : super(HomeIntial());

  final AuthService authService;

  // Fetch categories and products from the backend
  Future<void> fetchCategories() async {
    emit(HomeCategoriesLoading()); // Emit loading state to indicate the process has started
    try {
      // Fetch all products from the authentication service
      final products = await authService.getAllProducts();

      // Fetch all categories from the authentication service
      final categories = await authService.getAllCategories();

      // Emit success state with the fetched categories and products
      emit(HomeCategoriesSuccess(categories, products));
    } catch (e) {
      // Emit error state with an appropriate error message
      emit(HomeCategoriesError('Failed to load categories: $e'));
    }
  }
}
