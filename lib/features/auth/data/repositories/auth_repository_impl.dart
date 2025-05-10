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
  Future<void> signup({required User user}) {
    // TODO: implement signup
    throw UnimplementedError();
  }
}
