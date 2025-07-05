import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/products/data/datasources/product_firebasedatasource.dart';
import 'package:food_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/products/domain/usecases/get_products.dart';
import 'package:food_app/features/core/error/failures.dart';

class ProductsState {
  final List<Product> products;
  final bool isLoading;
  final Failure? failure;

  ProductsState({
    required this.products,
    required this.isLoading,
    required this.failure,
  });

  factory ProductsState.initial() {
    return ProductsState(products: [], isLoading: false, failure: null);
  }

  ProductsState copyWith({
    List<Product>? products,
    bool? isLoading,
    Failure? failure,
  }) {
    return ProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }
}

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
    StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  final getProductsUseCase = ref.read(getProductsProvider);
  return ProductsNotifier(getProductsUseCase: getProductsUseCase);
});

class ProductsNotifier extends StateNotifier<ProductsState> {
  final GetProducts getProductsUseCase;

  ProductsNotifier({required this.getProductsUseCase})
      : super(ProductsState.initial());

  Future<void> getProducts() async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await getProductsUseCase();

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
