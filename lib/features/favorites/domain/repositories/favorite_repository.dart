import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/favorites/domain/entities/favorite.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, List<Favorite>>> getUserFavorite({required User user});
  Future<Either<Failure, String>> addUserFavorite({required Favorite favorite});
  Future<Either<Failure, String>> removeUserFavorite(
      {required Favorite favorite});
}
