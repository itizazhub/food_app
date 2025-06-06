import 'package:dartz/dartz.dart';
import 'package:food_app/features/addresses/domain/entities/address.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/error/failures.dart';

abstract class AddressRepository {
  Future<Either<Failure, List<Address>>> getUserAddresses({required User user});
  Future<Either<Failure, Address>> addUserAddress({required Address address});
  Future<Either<Failure, String>> removeUserAddress({required Address address});
}
