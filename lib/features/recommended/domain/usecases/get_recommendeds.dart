import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/recommended/domain/repositories/recommended_respository.dart';

class GetRecommendeds {
  GetRecommendeds({required this.recommendedRespository});
  RecommendedRespository recommendedRespository;
  Future<Either<Failure, List<Product>>> call() {
    return recommendedRespository.getRecommendedProducts();
  }
}
