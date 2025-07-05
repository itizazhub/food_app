import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/reviews/data/datasources/review_firebasedatabase.dart';
import 'package:food_app/features/reviews/data/repositories/review_repository_impl.dart';
import 'package:food_app/features/reviews/domain/entities/review.dart';
import 'package:food_app/features/reviews/domain/usecases/add_review.dart';
import 'package:food_app/features/reviews/domain/usecases/get_reviews.dart';

final reviewFirebasedatasourceProvider =
    Provider<ReviewFirebasedatabase>((ref) {
  return ReviewFirebasedatabase();
});

final reviewRepositoryImplProvider = Provider<ReviewRepositoryImpl>((ref) {
  return ReviewRepositoryImpl(
      reviewFirebasedatabase: ref.watch(reviewFirebasedatasourceProvider));
});

final addReviewProvider = Provider<AddReview>((ref) {
  return AddReview(reviewRepository: ref.watch(reviewRepositoryImplProvider));
});

final getReviewsProvider = Provider<GetReviews>((ref) {
  return GetReviews(reviewRepository: ref.watch(reviewRepositoryImplProvider));
});

final reviewNotifierProvider =
    StateNotifierProvider<ReviewNotifier, List<Review>>((ref) {
  final getReviews = ref.watch(getReviewsProvider);
  final addReview = ref.watch(addReviewProvider);
  return ReviewNotifier(
      addReviewUseCase: addReview, getReviewsUseCase: getReviews);
});

class ReviewNotifier extends StateNotifier<List<Review>> {
  ReviewNotifier(
      {required this.addReviewUseCase, required this.getReviewsUseCase})
      : super([]);
  final GetReviews getReviewsUseCase;
  final AddReview addReviewUseCase;

  Future<void> getReviews({required Product product}) async {
    final failureOrReviews = await getReviewsUseCase(product: product);
    failureOrReviews.fold((failure) => print(failure.message), (reviews) {
      state = reviews;
    });
  }

  Future<void> addReview({required Review review}) async {
    final failureOrSuccess = await addReviewUseCase(review: review);
    failureOrSuccess.fold((failure) => print(failure.message),
        (Success) => print("review added successfully"));
  }
}
