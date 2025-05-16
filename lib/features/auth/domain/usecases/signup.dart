import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/error/failures.dart';

class Signup {
  Signup({required this.authRepository});
  AuthRepository authRepository;
  Future<Either<Failure, User>> call({required User user}) async {
    return authRepository.signup(user: user);
  }
}
