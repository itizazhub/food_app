import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/statuses/domain/entities/status.dart';

abstract class StatusRepository {
  Future<Either<Failure, List<Status>>> getStatuses();
}
