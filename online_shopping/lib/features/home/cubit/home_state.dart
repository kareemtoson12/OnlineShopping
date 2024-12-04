part of 'home_cubit.dart';

abstract class HomeState {}

class HomeIntial extends HomeState {}

// show categories at homeScreen
class HomeCategoriesLoading extends HomeState {}

class HomeCategoriesSuccess extends HomeState {
  final List<CategoryModel> categories;
  final List<ProductModel> products;

  HomeCategoriesSuccess(this.categories, this.products);
}

class HomeCategoriesError extends HomeState {
  final String errorMessage;

  HomeCategoriesError(this.errorMessage);
}

// show products at homeScreen
/* class HomeProductsiesLoading extends HomeState {}

class HomeProductsSuccess extends HomeState {
  final List<ProductModel> products;

  HomeProductsSuccess(this.products);
}

class HomeProductsError extends HomeState {
  final String errorMessage;

  HomeProductsError(this.errorMessage);
} */
