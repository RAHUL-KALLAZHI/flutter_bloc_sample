import 'package:bloc/bloc.dart';
import 'package:coolapps/domain/i_catalog_repo.dart';
import 'package:coolapps/domain/models/product_model/product_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ICatalogRepo _iCatalogRepo;
  ProductBloc(this._iCatalogRepo) : super(ProductState.initial()) {
    on<Loading>((event, emit) async {
      emit(const ProductState(
        isLoading: true,
        isError: false,
        products: [],
      ));
      final _result = await _iCatalogRepo.getAllProducts();
      emit(_result.fold(
        (failure) => state.copyWith(
          isLoading: false,
          isError: true,
          products: [],
        ),
        (success) => state.copyWith(
          isLoading: false,
          isError: false,
          products: success,
        ),
      ));
    });
  }
}
