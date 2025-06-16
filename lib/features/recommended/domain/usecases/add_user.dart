import 'package:food_app/features/users/domain/entities/user.dart';
import 'package:food_app/features/users/domain/repositories/user_repository.dart';

class AddUser {
  AddUser({required this.userRepository});
  UserRepository userRepository;
  Future<void> call(User user) async {
    userRepository.addUser(user: user);
  }
}
