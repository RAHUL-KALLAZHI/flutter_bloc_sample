import 'package:coolapps/domain/failures/mainfailure.dart';
import 'package:coolapps/domain/i_catalog_repo.dart';
import 'package:coolapps/domain/url.dart';
import 'package:dartz/dartz.dart';
import 'package:coolapps/domain/models/product_model/product_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ICatalogRepo)
class CatalogRepository implements ICatalogRepo {
  @override
  Future<Either<Mainfailure, List<ProductModel>>> getAllProducts() async {
    try {
      final Response response = await Dio(BaseOptions()).get(ApiUrls.products);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final _result = (response.data as List).map((e) {
          return ProductModel.fromJson(e);
        }).toList();

        print(_result);
        return Right(_result);
      } else {
        return const Left(Mainfailure.serverFailure());
      }
    } on DioError catch (o) {
      print("-------");
      print(o);
      return const Left(Mainfailure.serverFailure());
    } catch (e) {
      print("******");
      print(e);
      return const Left(Mainfailure.clientFailure());
    }
  }
}
