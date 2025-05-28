import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/home/data/datasources/product_firebasedatasource.dart';
import 'package:food_app/features/home/data/repositories/product_repository_impl.dart';
import 'package:food_app/features/home/domain/entities/product.dart';
import 'package:food_app/features/home/domain/usecases/get_products_by_category.dart';

final productsDatasource = Provider<ProductFirebasedatasource>((ref) {
  return ProductFirebasedatasource();
});

final productsRepository = Provider<ProductRepositoryImpl>((ref) {
  return ProductRepositoryImpl(
      productFirebasedatasource: ref.read(productsDatasource));
});

final getProductsByCategoryProvider = Provider<GetProductsByCategory>((ref) {
  return GetProductsByCategory(productRepository: ref.read(productsRepository));
});

final productsByCategoryNotifierProvider =
    StateNotifierProvider<ProductsByCategoryNotifier, List<Product>>((ref) {
  final getProductsByCategory = ref.read(getProductsByCategoryProvider);
  return ProductsByCategoryNotifier(
      getProductsByCategoryUseCase: getProductsByCategory);
});

class ProductsByCategoryNotifier extends StateNotifier<List<Product>> {
  ProductsByCategoryNotifier({required this.getProductsByCategoryUseCase})
      : super([]);
  GetProductsByCategory getProductsByCategoryUseCase;

  Future<void> getProductsByCategory({required String categoryId}) async {
    final productsOrFailure =
        await getProductsByCategoryUseCase(categoryId: categoryId);
    productsOrFailure.fold(
      (failure) {
        state = [];
        // Optionally log or handle error
        print(failure.message);
      },
      (products) {
        state = products;
      },
    );
  }
}
