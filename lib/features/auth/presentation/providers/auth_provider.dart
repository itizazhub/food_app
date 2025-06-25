import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/data/datasources/user_firebase_datasource.dart';
import 'package:food_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/auth/domain/usecases/login.dart';
import 'package:food_app/features/auth/domain/usecases/signup.dart';
import 'package:food_app/features/auth/domain/usecases/update_user_password.dart';
import 'package:food_app/features/auth/domain/usecases/update_user_profile.dart';

final datasource = Provider<UserFirebaseDatasource>((ref) {
  return UserFirebaseDatasource();
});

final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(userFirebaseDatasource: ref.read(datasource));
});

final loginUserProvider = Provider<Login>((ref) {
  return Login(authRepository: ref.read(authRepositoryProvider));
});

final signupUserProvider = Provider<Signup>((ref) {
  return Signup(authRepository: ref.read(authRepositoryProvider));
});

final updateUserProfileProvider = Provider<UpdateUserProfile>((ref) =>
    UpdateUserProfile(authRepository: ref.read(authRepositoryProvider)));
final updateUserPasswordProvider = Provider<UpdateUserPassword>((ref) =>
    UpdateUserPassword(authRepository: ref.read(authRepositoryProvider)));

final authUserNotifierProvider =
    StateNotifierProvider<AuthUserNotifier, User?>((ref) {
  final updateUserPassword = ref.read(updateUserPasswordProvider);
  final updateUserProfile = ref.read(updateUserProfileProvider);
  final loginUser = ref.read(loginUserProvider);
  final signupUser = ref.read(signupUserProvider);
  return AuthUserNotifier(
      loginUser: loginUser,
      signupUser: signupUser,
      updateUserPasswordUsecase: updateUserPassword,
      updateUserProfileUsecase: updateUserProfile);
});

class AuthUserNotifier extends StateNotifier<User?> {
  final Login loginUser;
  final Signup signupUser;
  final UpdateUserProfile updateUserProfileUsecase;
  final UpdateUserPassword updateUserPasswordUsecase;

  AuthUserNotifier(
      {required this.loginUser,
      required this.signupUser,
      required this.updateUserPasswordUsecase,
      required this.updateUserProfileUsecase})
      : super(null);

  Future<String> updateUserPassword({required User user}) async {
    String message = '';
    final result = await updateUserPasswordUsecase(user: user);
    result.fold((failure) => message = failure.message, (sucsess) {
      state = user;
      message = sucsess;
    });
    return message;
  }

  Future<String> updateUserProfile({required User user}) async {
    String message = '';
    final result = await updateUserProfileUsecase(user: user);
    result.fold((failure) => message = failure.message, (sucsess) {
      state = user;
      message = sucsess;
    });
    return message;
  }

  Future<void> login(
      {required String username, required String password}) async {
    try {
      final userOrFailure =
          await loginUser(password: password, username: username);
      state =
          userOrFailure.fold((error) => state = null, (user) => state = user);
    } catch (e) {
      state = null;
    }
  }

  Future<void> signup(
      {required String username,
      required String password,
      required String email}) async {
    try {
      final userOrFailure = await signupUser(
          user: User(
              id: '',
              username: username,
              email: email,
              password: password,
              isAdmin: false));
      state =
          userOrFailure.fold((error) => state = null, (user) => state = user);
    } catch (e) {
      state = null;
    }
  }
}
