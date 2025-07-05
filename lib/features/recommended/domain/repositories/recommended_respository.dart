import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/products/domain/entities/product.dart';

abstract class RecommendedRespository {
  Future<Either<Failure, List<Product>>> getRecommendedProducts();
}
