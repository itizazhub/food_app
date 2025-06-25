import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'dart:core';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(
      {required String username, required String password});
  Future<Either<Failure, User>> signup({required User user});
  Future<Either<Failure, String>> updateUserProfile({required User user});
  Future<Either<Failure, String>> updateUserPassword({required User user});
}
