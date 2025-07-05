import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/ratings/data/datasources/rating_firebasedatabase.dart';
import 'package:food_app/features/ratings/data/repositories/rating_repository_impl.dart';
import 'package:food_app/features/ratings/domain/entities/rating.dart';
import 'package:food_app/features/ratings/domain/usecases/add_rating.dart';
import 'package:food_app/features/ratings/domain/usecases/get_rating.dart';

final ratingFirebasedatabaseProvider = Provider<RatingFirebasedatabase>((ref) {
  return RatingFirebasedatabase();
});

final ratingRepositoryImplProvider = Provider<RatingRepositoryImpl>((ref) {
  return RatingRepositoryImpl(
      ratingFirebasedatabase: ref.watch(ratingFirebasedatabaseProvider));
});

final addRatingProvider = Provider<AddRating>((ref) {
  return AddRating(ratingRepository: ref.watch(ratingRepositoryImplProvider));
});

final getRatingProvider = Provider<GetRating>((ref) {
  return GetRating(ratingRepository: ref.watch(ratingRepositoryImplProvider));
});

final ratingNotifierProvider =
    StateNotifierProvider<RatingNotifier, double>((ref) {
  final addRating = ref.watch(addRatingProvider);
  final getRating = ref.watch(getRatingProvider);
  return RatingNotifier(
      addRatingUseCase: addRating, getRatingUseCase: getRating);
});

class RatingNotifier extends StateNotifier<double> {
  RatingNotifier(
      {required this.addRatingUseCase, required this.getRatingUseCase})
      : super(0.0);
  final AddRating addRatingUseCase;
  final GetRating getRatingUseCase;
  Future<void> addRating({required Rating rating}) async {
    final failureOrSucess = await addRatingUseCase(rating: rating);
    failureOrSucess.fold((failure) => print(failure.message),
        (sucess) => print("rating added sucessfully"));
  }

  Future<void> getRating({required Product procduct}) async {}
}
