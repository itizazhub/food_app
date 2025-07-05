import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/products/data/datasources/product_firebasedatasource.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required this.productFirebasedatasource});

  ProductFirebasedatasource productFirebasedatasource;
  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final productsOrFailure = await productFirebasedatasource.getProducts();

      return productsOrFailure.fold(
        (failure) => Left(failure),
        (products) => Right(
          products.map((productModel) => productModel.toEntity()).toList(),
        ),
      );
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
      {required String categoryId}) async {
    try {
      final productsOrFailure = await productFirebasedatasource
          .getProductsByCategory(categoryId: categoryId);

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
