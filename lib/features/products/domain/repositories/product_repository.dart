import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();

  Future<Either<Failure, List<Product>>> getProductsByCategory(
      {required String categoryId});
}
