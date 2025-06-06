import 'package:dartz/dartz.dart';
import 'package:food_app/features/addresses/domain/entities/address.dart';
import 'package:food_app/features/addresses/domain/repositories/address_repository.dart';
import 'package:food_app/features/core/error/failures.dart';

class RemoveUserAddress {
  RemoveUserAddress({required this.addressRepository});
  AddressRepository addressRepository;
  Future<Either<Failure, String>> call({required Address address}) {
    return addressRepository.removeUserAddress(address: address);
  }
}
