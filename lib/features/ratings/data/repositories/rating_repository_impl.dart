import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/ratings/data/datasources/rating_firebasedatabase.dart';
import 'package:food_app/features/ratings/domain/entities/rating.dart';
import 'package:food_app/features/ratings/domain/repositories/rating_repository.dart';

class RatingRepositoryImpl implements RatingRepository {
  RatingRepositoryImpl({required this.ratingFirebasedatabase});
  RatingFirebasedatabase ratingFirebasedatabase;
  @override
  Future<Either<Failure, Rating>> addRating({required Rating rating}) async {
    try {
      final failureOrRating =
          await ratingFirebasedatabase.addRating(rating: rating);
      return failureOrRating.fold((failure) {
        return Left(failure);
      }, (rating) {
        return Right(rating.toEntity());
      });
    } catch (e) {
      return Left(SomeSpecificError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getRating({required Product product}) async {
    try {
      final failureOrRating =
          await ratingFirebasedatabase.getRating(product: product);
      return failureOrRating.fold((failure) {
        return Left(failure);
      }, (rating) {
        return Right(rating);
      });
    } catch (e) {
      return Left(SomeSpecificError(e.toString()));
    }
  }
}
