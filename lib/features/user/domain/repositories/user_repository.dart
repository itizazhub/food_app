import 'package:food_app/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> addUser(User user);
  Future<void> deleteUser(String id);
  Future<void> updateUser(User user);
  Future<void> getUser({required String id});
}
