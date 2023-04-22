import 'package:coolapps/domain/failures/mainfailure.dart';
import 'package:coolapps/domain/models/product_model/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class ICatalogRepo {
  Future<Either<Mainfailure, List<ProductModel>>> getAllProducts();
}
