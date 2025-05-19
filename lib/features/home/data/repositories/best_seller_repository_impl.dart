import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/data/datasources/best_seller_firebasedatasource.dart';
import 'package:food_app/features/home/data/models/best_seller_model.dart';
import 'package:food_app/features/home/domain/entities/best_seller.dart';
import 'package:food_app/features/home/domain/repositories/best_seller_repository.dart';

class BestSellerRepositoryImpl implements BestSellerRepository {
  BestSellerRepositoryImpl({required this.bestSellerFirebasedatasource});

  BestSellerFirebasedatasource bestSellerFirebasedatasource;

  @override
  Future<Either<Failure, List<BestSeller>>> getBestSellers() async {
    try {
      List<BestSellerModel> bestSellers =
          await bestSellerFirebasedatasource.getBestSellers();
      return Right(bestSellers.map((bestSellerModel) {
        return bestSellerModel.toEntity();
      }).toList());
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }
}
