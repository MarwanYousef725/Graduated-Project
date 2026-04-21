part of 'product_cubit.dart';

sealed class ProductState {
  const ProductState();
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {}

final class ProductError extends ProductState {}

final class ProductEmpty extends ProductState {}

final class ProductFound extends ProductState {}

final class ProductNotFound extends ProductState {}

final class SortOption extends ProductState {}
