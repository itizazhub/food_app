import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/favorites/data/datasources/favorite_firebasedatasource.dart';
import 'package:food_app/features/favorites/domain/entities/favorite.dart';
import 'package:food_app/features/favorites/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  FavoriteRepositoryImpl({required this.favoriteFirebasedatasource});
  FavoriteFirebasedatasource favoriteFirebasedatasource;

  @override
  Future<Either<Failure, List<Favorite>>> getUserFavorite(
      {required User user}) async {
    try {
      final result =
          await favoriteFirebasedatasource.getUserFavorite(user: user);

      return result.fold(
          (failure) => Left(failure),
          (favorities) => Right(favorities.map((favoriteModel) {
                return favoriteModel.toEntity();
              }).toList()));
    } catch (e) {
      return Left(SomeSpecificError("some error happend while adding fav $e"));
    }
  }

  @override
  Future<Either<Failure, Favorite>> addUserFavorite(
      {required Favorite favorite}) async {
    try {
      final result =
          await favoriteFirebasedatasource.addUserFavorite(favorite: favorite);

      return result.fold(
          (failure) => Left(failure), (favorite) => Right(favorite.toEntity()));
    } catch (e) {
      return Left(SomeSpecificError("some error happend while adding fav $e"));
    }
  }

  @override
  Future<Either<Failure, String>> removeUserFavorite(
      {required Favorite favorite}) async {
    try {
      final result = await favoriteFirebasedatasource.removeUserFavorite(
          favorite: favorite);
      return result.fold(
          (failure) => Left(failure), (success) => Right(success));
    } catch (e) {
      return Left(
          SomeSpecificError("some error happend while removing fav $e"));
    }
  }
}
