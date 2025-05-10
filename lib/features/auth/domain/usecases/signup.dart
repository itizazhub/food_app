import 'package:food_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';

class Signup {
  Signup({required this.authRepository});
  AuthRepository authRepository;
  Future<void> call({required User user}) async {
    return authRepository.signup(user: user);
  }
}
