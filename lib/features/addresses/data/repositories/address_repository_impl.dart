import 'package:dartz/dartz.dart';
import 'package:food_app/features/addresses/data/datasources/address_firebasedatasource.dart';
import 'package:food_app/features/addresses/domain/entities/address.dart';
import 'package:food_app/features/addresses/domain/repositories/address_repository.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/error/failures.dart';

class AddressRepositoryImpl implements AddressRepository {
  AddressRepositoryImpl({required this.addressFirebasedatasource});
  AddressFirebasedatasource addressFirebasedatasource;

  @override
  Future<Either<Failure, List<Address>>> getUserAddresses(
      {required User user}) async {
    try {
      final failureOrAddresses =
          await addressFirebasedatasource.getUserAddresses(user: user);
      return failureOrAddresses.fold((failure) {
        return Left(failure);
      }, (addresses) {
        return Right(addresses.map((address) => address.toEntity()).toList());
      });
    } catch (e) {
      return Left(SomeSpecificError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Address>> addUserAddress(
      {required Address address}) async {
    try {
      final failureOrAddress =
          await addressFirebasedatasource.addUserAddress(address: address);
      return failureOrAddress.fold((failure) {
        return Left(failure);
      }, (address) {
        return Right(address.toEntity());
      });
    } catch (e) {
      return Left(SomeSpecificError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> removeUserAddress(
      {required Address address}) async {
    try {
      final failureOrSucessMessage =
          await addressFirebasedatasource.removeUserAddress(address: address);
      return failureOrSucessMessage.fold((failure) {
        return Left(failure);
      }, (sucessMessage) {
        return Right(sucessMessage);
      });
    } catch (e) {
      return Left(SomeSpecificError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Address>> updateUserAddress(
      {required Address address}) async {
    try {
      final failureOrAddress =
          await addressFirebasedatasource.updateUserAddress(address: address);
      return failureOrAddress.fold((failure) {
        return Left(failure);
      }, (address) {
        return Right(address.toEntity());
      });
    } catch (e) {
      return Left(SomeSpecificError(e.toString()));
    }
  }
}
