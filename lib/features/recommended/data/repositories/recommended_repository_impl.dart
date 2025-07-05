import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/recommended/data/datasources/recommended_firebasedatasource.dart';
import 'package:food_app/features/recommended/domain/repositories/recommended_respository.dart';

class RecommendedRepositoryImpl implements RecommendedRespository {
  RecommendedRepositoryImpl({required this.recommendedFirebasedatasource});

  RecommendedFirebasedatasource recommendedFirebasedatasource;
  @override
  Future<Either<Failure, List<Product>>> getRecommendedProducts() async {
    try {
      final failureOrRecommendedProducts =
          await recommendedFirebasedatasource.getRecommendedProducts();
      return failureOrRecommendedProducts.fold(
          (failure) => Left(failure),
          (recommendedProducts) => Right(recommendedProducts
              .map((product) => product.toEntity())
              .toList()));
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }
}
