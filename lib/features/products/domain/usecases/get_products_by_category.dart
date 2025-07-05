import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/products/domain/repositories/product_repository.dart';

class GetProductsByCategory {
  GetProductsByCategory({required this.productRepository});
  ProductRepository productRepository;
  Future<Either<Failure, List<Product>>> call({required String categoryId}) {
    return productRepository.getProductsByCategory(categoryId: categoryId);
  }
}
