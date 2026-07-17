part of 'product_cubit.dart';

sealed class ProductState {
  const ProductState();
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {}

final class ProductError extends ProductState {}

final class ChangeIndexState extends ProductState {}
