import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/statuses/data/datasources/status_firebasedatasource.dart';
import 'package:food_app/features/statuses/domain/entities/status.dart';
import 'package:food_app/features/statuses/domain/repositories/status_repository.dart';

class StatusRepositoryImpl implements StatusRepository {
  StatusRepositoryImpl({required this.statusFirebasedatasource});
  StatusFirebasedatasource statusFirebasedatasource;

  @override
  Future<Either<Failure, List<Status>>> getStatuses() async {
    try {
      final failureOrStatuses = await statusFirebasedatasource.getStatuses();
      return failureOrStatuses.fold((failure) {
        return Left(failure);
      }, (statuses) {
        return Right(statuses.map((status) => status.toEntity()).toList());
      });
    } catch (e) {
      return Left(SomeSpecificError(e.toString()));
    }
  }
}
