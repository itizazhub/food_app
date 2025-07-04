import 'package:dartz/dartz.dart';
import 'package:food_app/features/best_sellers/data/datasources/best_seller_firebasedatasource.dart';
import 'package:food_app/features/best_sellers/domain/repositories/best_seller_repository.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/products/domain/entities/product.dart';

class BestSellerRepositoryImpl implements BestSellerRepository {
  BestSellerRepositoryImpl({required this.bestSellerFirebasedatasource});

  BestSellerFirebasedatasource bestSellerFirebasedatasource;

  @override
  Future<Either<Failure, List<Product>>> getBestSellerProducts() async {
    try {
      final failureOrBestSellerProducts =
          await bestSellerFirebasedatasource.getBestSellerProducts();
      return failureOrBestSellerProducts.fold(
          (failure) => Left(failure),
          (bestSellerProducts) => Right(bestSellerProducts
              .map((product) => product.toEntity())
              .toList()));
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }
}
