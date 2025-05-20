import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/data/datasources/product_firebasedatasource.dart';
import 'package:food_app/features/home/domain/entities/product.dart';
import 'package:food_app/features/home/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required this.productFirebasedatasource});

  ProductFirebasedatasource productFirebasedatasource;
  @override
  Future<Either<Failure, List<Product>>> getProducts({
    required List<String> keys,
  }) async {
    try {
      final productsOrFailure =
          await productFirebasedatasource.getProducts(keys: keys);

      return productsOrFailure.fold(
        (failure) => Left(SomeSpecificError(failure.message)),
        (products) => Right(
          products.map((productModel) => productModel.toEntity()).toList(),
        ),
      );
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }
}
