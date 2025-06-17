import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/domain/entities/product.dart';
import 'package:food_app/features/reviews/data/datasources/review_firebasedatabase.dart';
import 'package:food_app/features/reviews/domain/entities/review.dart';
import 'package:food_app/features/reviews/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  ReviewRepositoryImpl({required this.reviewFirebasedatabase});
  ReviewFirebasedatabase reviewFirebasedatabase;
  @override
  Future<Either<Failure, Review>> addReview({required Review review}) async {
    try {
      final failureOrReview =
          await reviewFirebasedatabase.addReview(review: review);
      return failureOrReview.fold((failure) {
        return Left(failure);
      }, (review) {
        return Right(review.toEntity());
      });
    } catch (e) {
      return Left(SomeSpecificError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Review>>> getReviews(
      {required Product product}) async {
    try {
      final failureOrReview =
          await reviewFirebasedatabase.getReviews(product: product);
      return failureOrReview.fold((failure) {
        return Left(failure);
      }, (reviews) {
        return Right(reviews.map((review) {
          return review.toEntity();
        }).toList());
      });
    } catch (e) {
      return Left(SomeSpecificError(e.toString()));
    }
  }
}
