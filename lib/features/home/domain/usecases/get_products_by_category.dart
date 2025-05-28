import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/domain/entities/product.dart';
import 'package:food_app/features/home/domain/repositories/product_repository.dart';

class GetProductsByCategory {
  GetProductsByCategory({required this.productRepository});
  ProductRepository productRepository;
  Future<Either<Failure, List<Product>>> call({required String categoryId}) {
    return productRepository.getProductsByCategory(categoryId: categoryId);
  }
}
