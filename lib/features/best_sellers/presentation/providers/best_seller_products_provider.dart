import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/best_sellers/data/datasources/best_seller_firebasedatasource.dart';
import 'package:food_app/features/best_sellers/data/repositories/best_seller_repository_impl.dart';
import 'package:food_app/features/best_sellers/domain/usecases/get_best_sellers.dart';
import 'package:food_app/features/products/domain/entities/product.dart';

// --- State Class ---
import 'package:food_app/features/core/error/failures.dart';

class BestSellersState {
  final List<Product> products;
  final bool isLoading;
  final Failure? failure; // <-- Add this

  BestSellersState({
    required this.products,
    required this.isLoading,
    this.failure,
  });

  BestSellersState copyWith({
    List<Product>? products,
    bool? isLoading,
    Failure? failure,
  }) {
    return BestSellersState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }

  factory BestSellersState.initial() {
    return BestSellersState(
      products: [],
      isLoading: false,
      failure: null,
    );
  }
}

// --- Providers ---
final bestSellerFirebasedatasourceProvider =
    Provider<BestSellerFirebasedatasource>((ref) {
  return BestSellerFirebasedatasource();
});

final bestSellerRepositoryImplProvider =
    Provider<BestSellerRepositoryImpl>((ref) {
  return BestSellerRepositoryImpl(
    bestSellerFirebasedatasource:
        ref.read(bestSellerFirebasedatasourceProvider),
  );
});

final getBestSellersProvider = Provider<GetBestSellers>((ref) {
  return GetBestSellers(
    bestSellerRepository: ref.read(bestSellerRepositoryImplProvider),
  );
});

final bestSellersNotifierProvider =
    StateNotifierProvider<BestSellersNotifier, BestSellersState>((ref) {
  final getBestSellers = ref.read(getBestSellersProvider);
  return BestSellersNotifier(getBestSellersUseCase: getBestSellers);
});

// --- Notifier ---
class BestSellersNotifier extends StateNotifier<BestSellersState> {
  BestSellersNotifier({required this.getBestSellersUseCase})
      : super(BestSellersState.initial());

  final GetBestSellers getBestSellersUseCase;

  Future<void> getBestSellers() async {
    state = state.copyWith(isLoading: true, failure: null);

    final bestSellersOrFailure = await getBestSellersUseCase();

    bestSellersOrFailure.fold(
      (failure) {
        state = BestSellersState(
          products: [],
          isLoading: false,
          failure: failure,
        );
        print(failure.message);
      },
      (bestSellers) {
        state = BestSellersState(
          products: bestSellers,
          isLoading: false,
          failure: null,
        );
      },
    );
  }
}
