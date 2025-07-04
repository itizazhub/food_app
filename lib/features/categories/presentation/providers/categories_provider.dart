import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/home/data/datasources/category_firebasedatasource.dart';
import 'package:food_app/features/home/data/repositories/category_repository_impl.dart';
import 'package:food_app/features/home/domain/entities/category.dart';
import 'package:food_app/features/home/domain/usecases/get_categories.dart';
// import 'package:dartz/dartz.dart'; // Make sure you're using Either<Failure, List<Category>>

// ✅ 1. DataSource Provider
final categoryFirebasedatasourceProvider =
    Provider<CategoryFirebasedatasource>((ref) {
  return CategoryFirebasedatasource();
});

// ✅ 2. Repository Provider
final categoryRepositoryProvider = Provider<CategoryRepositoryImpl>((ref) {
  return CategoryRepositoryImpl(
    categoryFirebasedatasource: ref.read(categoryFirebasedatasourceProvider),
  );
});

// ✅ 3. UseCase Provider
final getCategoriesProvider = Provider<GetCategories>((ref) {
  return GetCategories(
    categoryRepository: ref.read(categoryRepositoryProvider),
  );
});

// ✅ 4. StateNotifier Provider
final categoriesNotifierProvider =
    StateNotifierProvider<CategoriesNotifier, List<Category>>((ref) {
  final getCategories = ref.read(getCategoriesProvider);
  return CategoriesNotifier(getCategoriesUseCase: getCategories);
});

// ✅ 5. Notifier Class
class CategoriesNotifier extends StateNotifier<List<Category>> {
  CategoriesNotifier({required this.getCategoriesUseCase}) : super([]);

  final GetCategories getCategoriesUseCase;

  Future<void> getCategories() async {
    final result = await getCategoriesUseCase();

    result.fold(
      (failure) {
        state = [];
        // Optionally log or handle error
        print(failure.message);
      },
      (categories) {
        state = categories;
      },
    );
  }
}
