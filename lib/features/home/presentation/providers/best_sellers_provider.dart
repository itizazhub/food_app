import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/home/data/datasources/best_seller_firebasedatasource.dart';
import 'package:food_app/features/home/data/repositories/best_seller_repository_impl.dart';
import 'package:food_app/features/home/domain/entities/best_seller.dart';
import 'package:food_app/features/home/domain/usecases/get_best_sellers.dart';

final bestSellerDatasourceProvider =
    Provider<BestSellerFirebasedatasource>((ref) {
  return BestSellerFirebasedatasource();
});

final bestSellerRepositoryImplProvider =
    Provider<BestSellerRepositoryImpl>((ref) {
  return BestSellerRepositoryImpl(
      bestSellerFirebasedatasource: ref.read(bestSellerDatasourceProvider));
});

final getBestSellerProvider = Provider<GetBestSellers>((ref) {
  return GetBestSellers(
      bestSellerRepository: ref.read(bestSellerRepositoryImplProvider));
});

final bestSellersNotifier =
    StateNotifierProvider<BestSellersNotifier, List<BestSeller>>((ref) {
  final getBestSellers = ref.read(getBestSellerProvider);
  return BestSellersNotifier(getBestSellersUseCase: getBestSellers);
});

class BestSellersNotifier extends StateNotifier<List<BestSeller>> {
  BestSellersNotifier({required this.getBestSellersUseCase}) : super([]);
  GetBestSellers getBestSellersUseCase;

  Future<void> getBestSellers() async {
    final bestSellersOrFailure = await getBestSellersUseCase();
    bestSellersOrFailure.fold(
      (failure) {
        state = [];
        // Optionally log or handle error
        print(failure.message);
      },
      (bestSellers) {
        state = bestSellers;
      },
    );
  }
}
