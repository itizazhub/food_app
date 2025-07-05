import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/products/data/datasources/product_firebasedatasource.dart';
import 'package:food_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/products/domain/usecases/get_products_by_category.dart';
import 'package:food_app/features/core/error/failures.dart';

class ProductsByCategoryState {
  final List<Product> products;
  final bool isLoading;
  final Failure? failure;
  String? categoryId;

  ProductsByCategoryState({
    required this.products,
    required this.isLoading,
    required this.failure,
    required this.categoryId,
  });

  factory ProductsByCategoryState.initial() => ProductsByCategoryState(
        products: [],
        isLoading: false,
        failure: null,
        categoryId: "-OQRvOxsOszWbpe78he7",
      );

  ProductsByCategoryState copyWith({
    List<Product>? products,
    bool? isLoading,
    Failure? failure,
    String? categoryId,
  }) {
    return ProductsByCategoryState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}

final productsFirebasedatasourceProvider =
    Provider<ProductFirebasedatasource>((ref) {
  return ProductFirebasedatasource();
});

final productsRepositoryImplProvider = Provider<ProductRepositoryImpl>((ref) {
  return ProductRepositoryImpl(
      productFirebasedatasource: ref.read(productsFirebasedatasourceProvider));
});

final getProductsByCategoryProvider = Provider<GetProductsByCategory>((ref) {
  return GetProductsByCategory(
      productRepository: ref.read(productsRepositoryImplProvider));
});

final productsByCategoryNotifierProvider =
    StateNotifierProvider<ProductsByCategoryNotifier, ProductsByCategoryState>(
        (ref) {
  final getProductsByCategory = ref.read(getProductsByCategoryProvider);
  return ProductsByCategoryNotifier(
    getProductsByCategoryUseCase: getProductsByCategory,
  );
});

class ProductsByCategoryNotifier
    extends StateNotifier<ProductsByCategoryState> {
  ProductsByCategoryNotifier({required this.getProductsByCategoryUseCase})
      : super(ProductsByCategoryState.initial());

  final GetProductsByCategory getProductsByCategoryUseCase;

  Future<void> getProductsByCategory({required String categoryId}) async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await getProductsByCategoryUseCase(categoryId: categoryId);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          products: [],
          failure: failure,
        );
        print(failure.message);
      },
      (products) {
        state = state.copyWith(
          isLoading: false,
          products: products,
          failure: null,
        );
      },
    );
  }
}
