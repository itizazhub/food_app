import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/data/datasources/recommended_firebasedatasource.dart';
import 'package:food_app/features/home/data/models/recommended_model.dart';
import 'package:food_app/features/home/domain/entities/recommended.dart';
import 'package:food_app/features/home/domain/repositories/recommended_respository.dart';

class RecommendedRepositoryImpl implements RecommendedRespository {
  RecommendedRepositoryImpl({required this.recommendedFirebasedatasource});

  RecommendedFirebasedatasource recommendedFirebasedatasource;
  @override
  Future<Either<Failure, List<Recommended>>> getRecommendeds() async {
    try {
      List<RecommendedModel> recommendeds =
          await recommendedFirebasedatasource.getRecommendeds();
      return Right(recommendeds.map((recommended) {
        return recommended.toEntity();
      }).toList());
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }
}
