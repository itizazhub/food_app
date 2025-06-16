import 'package:food_app/features/users/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> addUser({required User user});
  Future<void> deleteUser({required String id});
  Future<void> updateUser({required User user});
  Future<void> getUser({required String id});
}
