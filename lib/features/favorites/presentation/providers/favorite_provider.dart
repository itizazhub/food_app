import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/favorites/data/datasources/favorite_firebasedatasource.dart';
import 'package:food_app/features/favorites/data/repositories/favorite_repository_impl.dart';
import 'package:food_app/features/favorites/domain/entities/favorite.dart';
import 'package:food_app/features/favorites/domain/usecases/add_user_favorite.dart';
import 'package:food_app/features/favorites/domain/usecases/get_user_favorite.dart';
import 'package:food_app/features/favorites/domain/usecases/remove_user_favorite.dart';

/// DataSource Provider
final favoriteFirebaseDatasourceProvider = Provider<FavoriteFirebasedatasource>(
  (ref) => FavoriteFirebasedatasource(),
);

/// Repository Provider
final favoriteRepositoryProvider = Provider<FavoriteRepositoryImpl>(
  (ref) => FavoriteRepositoryImpl(
    favoriteFirebasedatasource: ref.read(favoriteFirebaseDatasourceProvider),
  ),
);

/// Use Case Providers
final getUserFavoriteProvider = Provider<GetUserFavorite>(
  (ref) =>
      GetUserFavorite(favoriteRepository: ref.read(favoriteRepositoryProvider)),
);

final addUserFavoriteProvider = Provider<AddUserFavorite>(
  (ref) =>
      AddUserFavorite(favoriteRepository: ref.read(favoriteRepositoryProvider)),
);

final removeUserFavoriteProvider = Provider<RemoveUserFavorite>(
  (ref) => RemoveUserFavorite(
      favoriteRepository: ref.read(favoriteRepositoryProvider)),
);

/// State Notifier Provider
final favoriteNotifierProvider =
    StateNotifierProvider<FavoriteNotifier, List<Favorite>>((ref) {
  return FavoriteNotifier(
    addUserFavoriteUseCase: ref.read(addUserFavoriteProvider),
    getUserFavoriteUseCase: ref.read(getUserFavoriteProvider),
    removeUserFavoriteUseCase: ref.read(removeUserFavoriteProvider),
  );
});

/// Favorite Notifier
class FavoriteNotifier extends StateNotifier<List<Favorite>> {
  final AddUserFavorite addUserFavoriteUseCase;
  final GetUserFavorite getUserFavoriteUseCase;
  final RemoveUserFavorite removeUserFavoriteUseCase;

  FavoriteNotifier({
    required this.addUserFavoriteUseCase,
    required this.getUserFavoriteUseCase,
    required this.removeUserFavoriteUseCase,
  }) : super([]);

  Future<void> addUserFavorite({required Favorite favorite}) async {
    final result = await addUserFavoriteUseCase(favorite: favorite);
    if (result.length() > 0) {
      result.fold(
        (failure) => print(failure.message),
        (id) {
          Favorite updated = favorite.copyWith(favoriteId: id);
          state = [...state, updated];
        },
      );
    } else {
      result.fold(
        (failure) => print(failure.message),
        (_) => state = [...state],
      );
    }
  }

  Future<void> removeUserFavorite({required Favorite favorite}) async {
    final result = await removeUserFavoriteUseCase(favorite: favorite);
    result.fold(
      (failure) => print(failure.message),
      (_) => state =
          state.where((f) => f.favoriteId != favorite.favoriteId).toList(),
    );
  }

  Future<void> getUserFavorite({required User user}) async {
    final result = await getUserFavoriteUseCase(user: user);
    result.fold(
      (failure) => print(failure.message),
      (favorites) => state = favorites,
    );
  }
}
