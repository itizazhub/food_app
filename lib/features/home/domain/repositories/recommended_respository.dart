import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/domain/entities/recommended.dart';

abstract class RecommendedRespository {
  Future<Either<Failure, List<Recommended>>> getRecommendeds();
}
