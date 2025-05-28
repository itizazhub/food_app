import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts(
      {required List<String> keys});

  Future<Either<Failure, List<Product>>> getProductsByCategory(
      {required String categoryId});
}
