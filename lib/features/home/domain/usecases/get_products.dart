import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/domain/entities/product.dart';
import 'package:food_app/features/home/domain/repositories/product_repository.dart';

class GetProducts {
  GetProducts({required this.productRepository});
  ProductRepository productRepository;
  Future<Either<Failure, List<Product>>> call({required List<String> keys}) {
    return productRepository.getProducts(keys: keys);
  }
}
