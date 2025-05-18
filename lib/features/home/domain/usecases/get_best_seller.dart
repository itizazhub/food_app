import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/domain/entities/best_seller.dart';
import 'package:food_app/features/home/domain/repositories/best_seller_repository.dart';

class GetBestSeller {
  GetBestSeller({required this.bestSellerRepository});
  BestSellerRepository bestSellerRepository;
  Future<Either<Failure, List<BestSeller>>> call() {
    return bestSellerRepository.getBestSeller();
  }
}
