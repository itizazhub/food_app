import 'package:dartz/dartz.dart';

import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/domain/entities/product.dart';

import 'package:food_app/features/ratings/domain/entities/rating.dart';

abstract class RatingRepository {
  Future<Either<Failure, Rating>> addRating({required Rating rating});
  Future<Either<Failure, double>> getRating({required Product product});
}
