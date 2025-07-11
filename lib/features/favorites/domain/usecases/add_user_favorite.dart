import 'package:dartz/dartz.dart';

import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/favorites/domain/entities/favorite.dart';
import 'package:food_app/features/favorites/domain/repositories/favorite_repository.dart';

class AddUserFavorite {
  AddUserFavorite({required this.favoriteRepository});
  FavoriteRepository favoriteRepository;
  Future<Either<Failure, Favorite>> call({required Favorite favorite}) {
    return favoriteRepository.addUserFavorite(favorite: favorite);
  }
}
