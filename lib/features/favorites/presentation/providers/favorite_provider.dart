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
  final Set<String> loadingProductIds; // productId currently updating
  final bool isFetchingFavorites; // for the initial fetch
  final Failure? failure;

  FavoriteState({
    required this.favorites,
    required this.loadingProductIds,
    required this.isFetchingFavorites,
    required this.failure,
  });

  factory FavoriteState.initial() => FavoriteState(
        favorites: [],
        loadingProductIds: {},
        isFetchingFavorites: false,
        failure: null,
      );

  FavoriteState copyWith({
    List<Favorite>? favorites,
    Set<String>? loadingProductIds,
    bool? isFetchingFavorites,
    Failure? failure,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      loadingProductIds: loadingProductIds ?? this.loadingProductIds,
      isFetchingFavorites: isFetchingFavorites ?? this.isFetchingFavorites,
      failure: failure,
    );
  }
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
    state = state.copyWith(
      loadingProductIds: {...state.loadingProductIds, favorite.productId},
      failure: null,
    );

    final result = await addUserFavoriteUseCase(favorite: favorite);

    result.fold(
      (failure) {
        state = state.copyWith(
          loadingProductIds: {...state.loadingProductIds}
            ..remove(favorite.productId),
          failure: failure,
        );
      },
      (createdFavorite) {
        state = state.copyWith(
          favorites: [...state.favorites, createdFavorite],
          loadingProductIds: {...state.loadingProductIds}
            ..remove(favorite.productId),
          failure: null,
        );
      },
    );
  }

  Future<void> removeUserFavorite({required Favorite favorite}) async {
    state = state.copyWith(
      loadingProductIds: {...state.loadingProductIds, favorite.productId},
      failure: null,
    );

    final result = await removeUserFavoriteUseCase(favorite: favorite);

    result.fold(
      (failure) {
        state = state.copyWith(
          loadingProductIds: {...state.loadingProductIds}
            ..remove(favorite.productId),
          failure: failure,
        );
      },
      (_) {
        final updatedFavorites = state.favorites
            .where((f) => f.favoriteId != favorite.favoriteId)
            .toList();

        state = state.copyWith(
          favorites: updatedFavorites,
          loadingProductIds: {...state.loadingProductIds}
            ..remove(favorite.productId),
          failure: null,
        );
      },
    );
  }

  Future<void> getUserFavorite({required User user}) async {
    state = state.copyWith(isFetchingFavorites: true, failure: null);

    final result = await getUserFavoriteUseCase(user: user);

    result.fold(
      (failure) =>
          state = state.copyWith(isFetchingFavorites: false, failure: failure),
      (favorites) => state = state.copyWith(
        isFetchingFavorites: false,
        favorites: favorites,
        failure: null,
      ),
    );
  }
}
