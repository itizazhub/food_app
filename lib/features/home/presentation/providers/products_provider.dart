import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/home/data/datasources/product_firebasedatasource.dart';
import 'package:food_app/features/home/data/repositories/product_repository_impl.dart';
import 'package:food_app/features/home/domain/entities/product.dart';
import 'package:food_app/features/home/domain/usecases/get_products.dart';

final productsDatasource = Provider<ProductFirebasedatasource>((ref) {
  return ProductFirebasedatasource();
});

final productsRepository = Provider<ProductRepositoryImpl>((ref) {
  return ProductRepositoryImpl(
      productFirebasedatasource: ref.read(productsDatasource));
});

final getProductsProvider = Provider<GetProducts>((ref) {
  return GetProducts(productRepository: ref.read(productsRepository));
});

final productsNotifierProvider =
    StateNotifierProvider<ProductsNotifier, List<Product>>((ref) {
  final getProductsUseCase = ref.read(getProductsProvider);
  return ProductsNotifier(getProductsUseCase: getProductsUseCase);
});

class ProductsNotifier extends StateNotifier<List<Product>> {
  ProductsNotifier({required this.getProductsUseCase}) : super([]);
  GetProducts getProductsUseCase;
  Future<void> getProducts({required List<String> keys}) async {
    final productsOrFailure = await getProductsUseCase(keys: keys);
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
