import 'package:dartz/dartz.dart';
import 'package:food_app/features/best_sellers/domain/repositories/best_seller_repository.dart';
import 'package:food_app/features/core/error/failures.dart';

import 'package:food_app/features/products/domain/entities/product.dart';

class GetBestSellers {
  GetBestSellers({required this.bestSellerRepository});
  BestSellerRepository bestSellerRepository;
  Future<Either<Failure, List<Product>>> call() {
    return bestSellerRepository.getBestSellerProducts();
  }
}
