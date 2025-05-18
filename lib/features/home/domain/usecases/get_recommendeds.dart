import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/domain/entities/recommended.dart';
import 'package:food_app/features/home/domain/repositories/recommended_respository.dart';

class GetRecommendeds {
  GetRecommendeds({required this.recommendedRespository});
  RecommendedRespository recommendedRespository;
  Future<Either<Failure, List<Recommended>>> call() {
    return recommendedRespository.getRecommendeds();
  }
}
