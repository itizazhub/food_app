import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/data/datasources/user_firebase_datasource.dart';
import 'package:food_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/auth/domain/usecases/login.dart';

final datasource = Provider<UserFirebaseDatasource>((ref) {
  return UserFirebaseDatasource();
});

final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(userFirebaseDatasource: ref.read(datasource));
});

final loginUserProvider = Provider<Login>((ref) {
  return Login(authRepository: ref.read(authRepositoryProvider));
});

final authUserNotifierProvider =
    StateNotifierProvider<AuthUserNotifier, User?>((ref) {
  final loginUser = ref.read(loginUserProvider);
  return AuthUserNotifier(loginUser: loginUser);
});

class AuthUserNotifier extends StateNotifier<User?> {
  final Login loginUser;

  AuthUserNotifier({required this.loginUser}) : super(null);

  Future<void> login(
      {required String username, required String password}) async {
    try {
      final userOrFailure =
          await loginUser(password: password, username: username);
      state =
          userOrFailure.fold((error) => state = null, (user) => state = user);
    } catch (e, st) {
      state = null;
    }
  }
}
