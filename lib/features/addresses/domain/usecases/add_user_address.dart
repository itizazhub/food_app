import 'package:dartz/dartz.dart';
import 'package:food_app/features/addresses/domain/entities/address.dart';
import 'package:food_app/features/addresses/domain/repositories/address_repository.dart';
import 'package:food_app/features/core/error/failures.dart';

class AddUserAddress {
  AddUserAddress({required this.addressRepository});
  AddressRepository addressRepository;
  Future<Either<Failure, Address>> call({required Address address}) {
    return addressRepository.addUserAddresses(address: address);
  }
}
