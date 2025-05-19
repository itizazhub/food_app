import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/home/data/datasources/recommended_firebasedatasource.dart';
import 'package:food_app/features/home/data/repositories/recommended_repository_impl.dart';
import 'package:food_app/features/home/domain/entities/recommended.dart';
import 'package:food_app/features/home/domain/usecases/get_recommendeds.dart';

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
    StateNotifierProvider<RecommendedNotifier, List<Recommended>>((ref) {
  final getRecommendeds = ref.read(getRecommendedsProvider);
  return RecommendedNotifier(getRecommendedsUseCase: getRecommendeds);
});

class RecommendedNotifier extends StateNotifier<List<Recommended>> {
  RecommendedNotifier({required this.getRecommendedsUseCase}) : super([]);
  final GetRecommendeds getRecommendedsUseCase;

  Future<void> getRecommendeds() async {
    final recommendedsOrFailure = await getRecommendedsUseCase();
    recommendedsOrFailure.fold(
      (failure) {
        state = [];
        print(failure.message); // Optional: log error
      },
      (recommendeds) {
        state = recommendeds;
      },
    );
  }
}
