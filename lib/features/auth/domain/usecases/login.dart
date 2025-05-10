import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';

class Login {
  Login({required this.authRepository});
  AuthRepository authRepository;
  Future<Either<Failure, User>> call(
      {required String username, required String password}) async {
    return authRepository.login(username: username, password: password);
  }
}
