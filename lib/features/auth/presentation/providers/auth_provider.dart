import 'package:flutter/material.dart';
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

class AuthUserState {
  User? user;
  String? username;
  String? password;
  bool isLoading;
  String? confirmPassword;
  String? email;

  AuthUserState({
    required this.user,
    required this.isLoading,
    required this.password,
    required this.username,
    required this.confirmPassword,
    required this.email,
  });

  AuthUserState copyWith({
    User? user,
    bool? isLoading,
    String? username,
    String? password,
    String? confirmPassword,
    String? email,
  }) {
    return AuthUserState(
      user: user ?? this.user,
      username: username ?? this.username,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      email: email ?? this.email,
    );
  }

  factory AuthUserState.initial() => AuthUserState(
      user: null,
      isLoading: false,
      username: null,
      password: null,
      confirmPassword: null,
      email: null);
}

final authUserNotifierProvider =
    StateNotifierProvider<AuthUserNotifier, AuthUserState>((ref) {
  final updateUserPassword = ref.read(updateUserPasswordProvider);
  final updateUserProfile = ref.read(updateUserProfileProvider);
  final loginUser = ref.read(loginUserProvider);
  final signupUser = ref.read(signupUserProvider);

  return AuthUserNotifier(
    loginUser: loginUser,
    signupUser: signupUser,
    updateUserPasswordUsecase: updateUserPassword,
    updateUserProfileUsecase: updateUserProfile,
  );
});

class AuthUserNotifier extends StateNotifier<AuthUserState> {
  final Login loginUser;
  final Signup signupUser;
  final UpdateUserProfile updateUserProfileUsecase;
  final UpdateUserPassword updateUserPasswordUsecase;

  AuthUserNotifier({
    required this.loginUser,
    required this.signupUser,
    required this.updateUserPasswordUsecase,
    required this.updateUserProfileUsecase,
  }) : super(AuthUserState.initial());

  Future<void> login(
      {required String username, required String password}) async {
    state = state.copyWith(isLoading: true);
    try {
      final result = await loginUser(username: username, password: password);
      result.fold(
        (failure) => state = state.copyWith(user: null),
        (user) => state = state.copyWith(user: user),
      );
    } catch (e) {
      state = state.copyWith(user: null);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> signup({
    required String username,
    required String password,
    required String email,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final result = await signupUser(
        user: User(
          id: '',
          username: username,
          email: email,
          password: password,
          isAdmin: false,
        ),
      );
      result.fold(
        (failure) => state = state.copyWith(user: null),
        (user) => state = state.copyWith(user: user),
      );
    } catch (e) {
      state = state.copyWith(user: null);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<String> updateUserPassword({required User user}) async {
    state = state.copyWith(isLoading: true);
    String message = '';
    final result = await updateUserPasswordUsecase(user: user);
    result.fold(
      (failure) => message = failure.message,
      (success) {
        state = state.copyWith(user: user);
        message = success;
      },
    );
    state = state.copyWith(isLoading: false);
    return message;
  }

  Future<String> updateUserProfile({required User user}) async {
    state = state.copyWith(isLoading: true);
    String message = '';
    final result = await updateUserProfileUsecase(user: user);
    result.fold(
      (failure) => message = failure.message,
      (success) {
        state = state.copyWith(user: user);
        message = success;
      },
    );
    state = state.copyWith(isLoading: false);
    return message;
  }
}
