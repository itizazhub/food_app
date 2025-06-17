import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';

import 'package:food_app/features/reviews/domain/entities/review.dart';
import 'package:food_app/features/reviews/domain/repositories/review_repository.dart';

class AddReview {
  AddReview({required this.reviewRepository});

  ReviewRepository reviewRepository;
  Future<Either<Failure, Review>> call({required Review review}) {
    return reviewRepository.addReview(review: review);
  }
}
