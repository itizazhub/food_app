import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/statuses/domain/entities/status.dart';
import 'package:food_app/features/statuses/domain/repositories/status_repository.dart';

class GetStatus {
  GetStatus({required this.statusRepository});
  StatusRepository statusRepository;

  Future<Either<Failure, List<Status>>> call() {
    return statusRepository.getStatuses();
  }
}
