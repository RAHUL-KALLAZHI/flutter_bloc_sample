part of 'product_bloc.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    required bool isLoading,
    required bool isError,
    required List<ProductModel> products,
  }) = _ProductState;
  factory ProductState.initial() {
    return const ProductState(
      isLoading: false,
      isError: false,
      products: [],
    );
  }
}
