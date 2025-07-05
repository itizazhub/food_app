import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/favorites/data/datasources/favorite_firebasedatasource.dart';
import 'package:food_app/features/favorites/data/models/favorite_model.dart';
import 'package:food_app/features/favorites/domain/entities/favorite.dart';
import 'package:food_app/features/favorites/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  FavoriteRepositoryImpl({required this.favoriteFirebasedatasource});
  FavoriteFirebasedatasource favoriteFirebasedatasource;
  @override
  Future<Either<Failure, String>> addUserFavorite(
      {required Favorite favorite}) async {
    try {
      final result = await favoriteFirebasedatasource
          .addUserFavorite(FavoriteModel.fromEntity(favorite: favorite));
      return Right(result);
    } catch (e) {
      return Left(SomeSpecificError("some error happend while adding fav $e"));
    }
  }

  @override
  Future<Either<Failure, List<Favorite>>> getUserFavorite(
      {required User user}) async {
    try {
      final favs = await favoriteFirebasedatasource.getUserFavorite(user: user);
      return Right(favs.map((favoriteModel) {
        return favoriteModel.toEntity(favoriteModel: favoriteModel);
      }).toList());
    } catch (e) {
      return Left(SomeSpecificError("some error happend while adding fav $e"));
    }
  }

  @override
  Future<Either<Failure, String>> removeUserFavorite(
      {required Favorite favorite}) async {
    try {
      await favoriteFirebasedatasource
          .removeUserFavorite(FavoriteModel.fromEntity(favorite: favorite));
      return const Right("fav removed sucessfully");
    } catch (e) {
      return Left(
          SomeSpecificError("some error happend while removing fav $e"));
    }
  }
}
