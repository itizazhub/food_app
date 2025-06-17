import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/domain/entities/product.dart';

import 'package:food_app/features/reviews/domain/entities/review.dart';
import 'package:food_app/features/reviews/domain/repositories/review_repository.dart';

class GetReviews {
  GetReviews({required this.reviewRepository});

  ReviewRepository reviewRepository;
  Future<Either<Failure, List<Review>>> call({required Product product}) {
    return reviewRepository.getReviews(product: product);
  }
}
