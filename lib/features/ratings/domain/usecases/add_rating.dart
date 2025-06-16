import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/ratings/domain/entities/rating.dart';
import 'package:food_app/features/ratings/domain/repositories/rating_repository.dart';

class AddRating {
  AddRating({required this.ratingRepository});

  RatingRepository ratingRepository;
  Future<Either<Failure, Rating>> call({required Rating rating}) {
    return ratingRepository.addRating(rating: rating);
  }
}
