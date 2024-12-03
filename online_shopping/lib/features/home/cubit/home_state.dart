part of 'home_cubit.dart';

abstract class HomeState {}

class HomeIntial extends HomeState {}

class HomeCategoriesLoading extends HomeState {}

class HomeCategoriesSuccess extends HomeState {
  final List<CategoryModel> categories;

  HomeCategoriesSuccess(this.categories);
}

class HomeCategoriesError extends HomeState {
  final String errorMessage;

  HomeCategoriesError(this.errorMessage);
}
