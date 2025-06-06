import 'package:dartz/dartz.dart';
import 'package:food_app/features/addresses/domain/entities/address.dart';
import 'package:food_app/features/addresses/domain/repositories/address_repository.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/error/failures.dart';

class GetUserAddresses {
  GetUserAddresses({required this.addressRepository});
  AddressRepository addressRepository;
  Future<Either<Failure, List<Address>>> call({required User user}) {
    return addressRepository.getUserAddresses(user: user);
  }
}
