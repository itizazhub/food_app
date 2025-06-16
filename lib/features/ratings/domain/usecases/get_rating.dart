import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/domain/entities/product.dart';

import 'package:food_app/features/ratings/domain/repositories/rating_repository.dart';

class GetRating {
  GetRating({required this.ratingRepository});

  RatingRepository ratingRepository;
  Future<Either<Failure, double>> call({required Product product}) {
    return ratingRepository.getRating(product: product);
  }
}
