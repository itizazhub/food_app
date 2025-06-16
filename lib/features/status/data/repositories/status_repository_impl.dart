import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/status/data/datasources/status_firebasedatasource.dart';
import 'package:food_app/features/status/domain/entities/status.dart';
import 'package:food_app/features/status/domain/repositories/status_repository.dart';

class StatusRepositoryImpl implements StatusRepository {
  StatusRepositoryImpl({required this.statusFirebasedatasource});
  StatusFirebasedatasource statusFirebasedatasource;

  @override
  Future<Either<Failure, List<Status>>> getStatuses() {
    // TODO: implement getStatuses
    throw UnimplementedError();
  }
}
