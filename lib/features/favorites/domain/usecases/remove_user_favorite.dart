import 'package:dartz/dartz.dart';

import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/favorites/domain/entities/favorite.dart';
import 'package:food_app/features/favorites/domain/repositories/favorite_repository.dart';

class RemoveUserFavorite {
  RemoveUserFavorite({required this.favoriteRepository});
  FavoriteRepository favoriteRepository;
  Future<Either<Failure, String>> call({required Favorite favorite}) {
    return favoriteRepository.removeUserFavorite(favorite: favorite);
  }
}
