import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/recommended/data/datasources/recommended_firebasedatasource.dart';
import 'package:food_app/features/recommended/data/repositories/recommended_repository_impl.dart';
import 'package:food_app/features/recommended/domain/usecases/get_recommendeds.dart';
import 'package:food_app/features/core/error/failures.dart';

class RecommendedState {
  final List<Product> products;
  final bool isLoading;
  final Failure? failure;

  RecommendedState({
    required this.products,
    this.isLoading = false,
    this.failure,
  });

  RecommendedState copyWith({
    List<Product>? products,
    bool? isLoading,
    Failure? failure,
  }) {
    return RecommendedState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }

  factory RecommendedState.initial() {
    return RecommendedState(products: [], isLoading: false, failure: null);
  }
}

final recommendedDatasource = Provider<RecommendedFirebasedatasource>((ref) {
  return RecommendedFirebasedatasource();
});

final recommendedRepository = Provider<RecommendedRepositoryImpl>((ref) {
  return RecommendedRepositoryImpl(
    recommendedFirebasedatasource: ref.read(recommendedDatasource),
  );
});

final getRecommendedsProvider = Provider<GetRecommendeds>((ref) {
  return GetRecommendeds(
    recommendedRespository: ref.read(recommendedRepository),
  );
});

final recommendedNotifierProvider =
    StateNotifierProvider<RecommendedNotifier, RecommendedState>((ref) {
  final getRecommendeds = ref.read(getRecommendedsProvider);
  return RecommendedNotifier(getRecommendedsUseCase: getRecommendeds);
});

class RecommendedNotifier extends StateNotifier<RecommendedState> {
  RecommendedNotifier({required this.getRecommendedsUseCase})
      : super(RecommendedState.initial());

  final GetRecommendeds getRecommendedsUseCase;

  Future<void> getRecommendedProducts() async {
    state = state.copyWith(isLoading: true, failure: null);

    final failureOrRecommendedProducts = await getRecommendedsUseCase();

    failureOrRecommendedProducts.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          failure: failure,
          products: [],
        );
      },
      (recommendedProducts) {
        state = state.copyWith(
          isLoading: false,
          products: recommendedProducts,
          failure: null,
        );
      },
    );
  }
}
