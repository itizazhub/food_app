import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/categories/data/datasources/category_firebasedatasource.dart';
import 'package:food_app/features/categories/data/repositories/category_repository_impl.dart';
import 'package:food_app/features/categories/domain/entities/category.dart';
import 'package:food_app/features/categories/domain/usecases/get_categories.dart';
import 'package:food_app/features/core/error/failures.dart';

class CategoriesState {
  final List<Category> categories;
  final bool isLoading;
  final Failure? failure;

  CategoriesState({
    required this.categories,
    required this.isLoading,
    this.failure,
  });

  factory CategoriesState.initial() => CategoriesState(
        categories: [],
        isLoading: false,
        failure: null,
      );

  CategoriesState copyWith({
    List<Category>? categories,
    bool? isLoading,
    Failure? failure,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }
}

//  DataSource Provider
final categoryFirebasedatasourceProvider =
    Provider<CategoryFirebasedatasource>((ref) {
  return CategoryFirebasedatasource();
});

// Repository Provider
final categoryRepositoryProvider = Provider<CategoryRepositoryImpl>((ref) {
  return CategoryRepositoryImpl(
    categoryFirebasedatasource: ref.read(categoryFirebasedatasourceProvider),
  );
});

// UseCase Provider
final getCategoriesProvider = Provider<GetCategories>((ref) {
  return GetCategories(
    categoryRepository: ref.read(categoryRepositoryProvider),
  );
});

// StateNotifier Provider
final categoriesNotifierProvider =
    StateNotifierProvider<CategoriesNotifier, CategoriesState>((ref) {
  final getCategories = ref.read(getCategoriesProvider);
  return CategoriesNotifier(getCategoriesUseCase: getCategories);
});

//  Notifier Class
class CategoriesNotifier extends StateNotifier<CategoriesState> {
  CategoriesNotifier({required this.getCategoriesUseCase})
      : super(CategoriesState.initial());

  final GetCategories getCategoriesUseCase;

  Future<void> getCategories() async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await getCategoriesUseCase();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          categories: [],
          failure: failure,
        );
        print(failure.message);
      },
      (categories) {
        state = state.copyWith(
          isLoading: false,
          categories: categories,
          failure: null,
        );
      },
    );
  }
}
