import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/error/failures.dart';

class UpdateUserProfile {
  UpdateUserProfile({required this.authRepository});
  AuthRepository authRepository;
  Future<Either<Failure, String>> call({required User user}) async {
    return authRepository.updateUserProfile(user: user);
  }
}
