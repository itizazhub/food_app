import 'package:food_app/features/user/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login({required String username, required String password});
  Future<void> signup({required User user});
}
