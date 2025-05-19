import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/data/datasources/user_firebase_datasource.dart';
import 'package:food_app/features/auth/data/models/user_model.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:food_app/features/core/error/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.userFirebaseDatasource});
  final UserFirebaseDatasource userFirebaseDatasource;
  @override
  Future<Either<Failure, User>> login(
      {required String username, required String password}) async {
    try {
      List<UserModel> users = await userFirebaseDatasource.getUsers();
      final user = users.firstWhere((user) {
        return (user.username == username && user.password == password);
      });
      return Right(user.toEntity());
    } catch (error) {
      print("something get wrong with login: $error");
      return Left(SomeSpecificError(error.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signup({required User user}) async {
    try {
      List<UserModel> users = await userFirebaseDatasource.getUsers();

      // Check if a user with the same username already exists
      UserModel? existingUser =
          users.firstWhereOrNull((u) => u.username == user.username);

      if (existingUser != null) {
        return Left(SomeSpecificError(
            "User ${existingUser.username} is already available"));
      }

      // User doesn't exist, create a new one
      UserModel newUser = UserModel.fromEntity(user);
      final userOrFailure = await userFirebaseDatasource.createUser(newUser);

      return userOrFailure
          .map((createdUserModel) => createdUserModel.toEntity());
    } catch (error) {
      print("Something went wrong during signup: $error");
      return Left(SomeSpecificError(error.toString()));
    }
  }
}
