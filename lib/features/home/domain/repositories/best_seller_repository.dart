import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/domain/entities/best_seller.dart';

abstract class BestSellerRepository {
  Future<Either<Failure, List<BestSeller>>> getBestSeller();
}
