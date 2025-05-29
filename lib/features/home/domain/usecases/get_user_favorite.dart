import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';

import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/domain/entities/favorite.dart';
import 'package:food_app/features/home/domain/repositories/favorite_repository.dart';

class GetUserFavorite {
  GetUserFavorite({required this.favoriteRepository});
  FavoriteRepository favoriteRepository;
  Future<Either<Failure, List<Favorite>>> call({required User user}) {
    return favoriteRepository.getUserFavorite(user: user);
  }
}
