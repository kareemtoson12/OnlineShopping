part of 'home_cubit.dart';

abstract class HomeState {}

class HomeIntial extends HomeState {}

class HomeCategoriesLoading extends HomeState {}

class HomeCategoriesSucess extends HomeState {}

class HomeCategoriesError extends HomeState {
  final String message;
  HomeCategoriesError(this.message);
}
