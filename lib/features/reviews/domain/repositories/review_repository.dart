import 'package:dartz/dartz.dart';

import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/products/domain/entities/product.dart';

import 'package:food_app/features/reviews/domain/entities/review.dart';

abstract class ReviewRepository {
  Future<Either<Failure, Review>> addReview({required Review review});
  Future<Either<Failure, List<Review>>> getReviews({required Product product});
}
