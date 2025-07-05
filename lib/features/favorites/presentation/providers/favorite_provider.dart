import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/favorites/data/datasources/favorite_firebasedatasource.dart';
import 'package:food_app/features/favorites/data/repositories/favorite_repository_impl.dart';
import 'package:food_app/features/favorites/domain/entities/favorite.dart';
import 'package:food_app/features/favorites/domain/usecases/add_user_favorite.dart';
import 'package:food_app/features/favorites/domain/usecases/get_user_favorite.dart';
import 'package:food_app/features/favorites/domain/usecases/remove_user_favorite.dart';
import 'package:food_app/features/core/error/failures.dart';

class FavoriteState {
  final List<Favorite> favorites;
  final bool isLoading;
  final Failure? failure;

  const FavoriteState({
    required this.favorites,
    this.isLoading = false,
    this.failure,
  });

  FavoriteState copyWith({
    List<Favorite>? favorites,
    bool? isLoading,
    Failure? failure,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }

  factory FavoriteState.initial() => const FavoriteState(favorites: []);
}

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
    StateNotifierProvider<FavoriteNotifier, FavoriteState>((ref) {
  return FavoriteNotifier(
    addUserFavoriteUseCase: ref.read(addUserFavoriteProvider),
    getUserFavoriteUseCase: ref.read(getUserFavoriteProvider),
    removeUserFavoriteUseCase: ref.read(removeUserFavoriteProvider),
  );
});

/// Favorite Notifier
class FavoriteNotifier extends StateNotifier<FavoriteState> {
  final AddUserFavorite addUserFavoriteUseCase;
  final GetUserFavorite getUserFavoriteUseCase;
  final RemoveUserFavorite removeUserFavoriteUseCase;

  FavoriteNotifier({
    required this.addUserFavoriteUseCase,
    required this.getUserFavoriteUseCase,
    required this.removeUserFavoriteUseCase,
  }) : super(FavoriteState.initial());

  Future<void> addUserFavorite({required Favorite favorite}) async {
    state = state.copyWith(isLoading: true, failure: null);
    final result = await addUserFavoriteUseCase(favorite: favorite);

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (favorite) {
        state = state.copyWith(
          favorites: [...state.favorites, favorite],
          isLoading: false,
          failure: null,
        );
      },
    );
  }

  Future<void> removeUserFavorite({required Favorite favorite}) async {
    final result = await removeUserFavoriteUseCase(favorite: favorite);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (success) => state = state.copyWith(favorites: [
        ...state.favorites.where((f) => f.favoriteId != favorite.favoriteId)
      ], isLoading: false, failure: SomeSpecificError(success)),
    );
  }

  Future<void> getUserFavorite({required User user}) async {
    state = state.copyWith(isLoading: true, failure: null);
    final result = await getUserFavoriteUseCase(user: user);

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (favorites) => state = state.copyWith(
        isLoading: false,
        favorites: favorites,
        failure: null,
      ),
    );
  }
}
