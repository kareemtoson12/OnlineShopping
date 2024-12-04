import 'package:bloc/bloc.dart';
import 'package:online_shopping/core/services/auth_service.dart';
import 'package:online_shopping/features/home/models/category_model.dart';
import 'package:online_shopping/features/product/models/product_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.authService) : super(HomeIntial());

  final AuthService authService;

  //  categories

  Future<void> fetchCategories() async {
    emit(HomeCategoriesLoading());
    try {
      final products = await authService.getAllProducts();
      final categories = await authService.getAllCategories();
      emit(HomeCategoriesSuccess(categories, products));
    } catch (e) {
      emit(HomeCategoriesError('Failed to load categories: $e'));
    }
  }
}
