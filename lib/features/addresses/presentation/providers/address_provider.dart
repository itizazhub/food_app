import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/addresses/data/datasources/address_firebasedatasource.dart';
import 'package:food_app/features/addresses/data/repositories/address_repository_impl.dart';
import 'package:food_app/features/addresses/domain/entities/address.dart';
import 'package:food_app/features/addresses/domain/usecases/add_user_address.dart';
import 'package:food_app/features/addresses/domain/usecases/get_user_addresses.dart';
import 'package:food_app/features/addresses/domain/usecases/remove_user_address.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:flutter/foundation.dart';

/// Firebase data source
final addressFirebasedatasourceProvider =
    Provider<AddressFirebasedatasource>((ref) {
  return AddressFirebasedatasource();
});

/// Repository
final addressRepositoryProvider = Provider<AddressRepositoryImpl>((ref) {
  return AddressRepositoryImpl(
    addressFirebasedatasource: ref.watch(addressFirebasedatasourceProvider),
  );
});

/// Use Cases
final getUserAddressesProvider = Provider<GetUserAddresses>((ref) {
  return GetUserAddresses(
      addressRepository: ref.watch(addressRepositoryProvider));
});

final addUserAddressProvider = Provider<AddUserAddress>((ref) {
  return AddUserAddress(
      addressRepository: ref.watch(addressRepositoryProvider));
});

final removeUserAddressProvider = Provider<RemoveUserAddress>((ref) {
  return RemoveUserAddress(
      addressRepository: ref.watch(addressRepositoryProvider));
});

/// Notifier Provider
final addressNotifierProvider =
    StateNotifierProvider<AddressNotifier, List<Address>>((ref) {
  return AddressNotifier(
    getUserAddressesUseCase: ref.watch(getUserAddressesProvider),
    addUserAddressUseCase: ref.watch(addUserAddressProvider),
    removeUserAddressUseCase: ref.watch(removeUserAddressProvider),
  );
});

/// Address Notifier
class AddressNotifier extends StateNotifier<List<Address>> {
  final GetUserAddresses getUserAddressesUseCase;
  final AddUserAddress addUserAddressUseCase;
  final RemoveUserAddress removeUserAddressUseCase;

  AddressNotifier({
    required this.getUserAddressesUseCase,
    required this.addUserAddressUseCase,
    required this.removeUserAddressUseCase,
  }) : super([]);

  /// Get all addresses of a user
  Future<void> getUserAddresses({required User user}) async {
    final result = await getUserAddressesUseCase(user: user);
    result.fold(
      (failure) {
        debugPrint("Failed to get addresses: ${failure.message}");
      },
      (addresses) {
        state = [...addresses];
      },
    );
  }

  /// Add a new address
  Future<void> addUserAddress({required Address address}) async {
    final result = await addUserAddressUseCase(address: address);
    result.fold(
      (failure) {
        debugPrint("Failed to add address: ${failure.message}");
      },
      (address) {
        // Avoid duplicates
        if (!state.any((a) => a.addressId == address.addressId)) {
          state = [...state, address];
        }
      },
    );
  }

  /// Remove an address
  Future<void> removeUserAddress({required Address address}) async {
    final result = await removeUserAddressUseCase(address: address);
    result.fold(
      (failure) {
        debugPrint("Failed to remove address: ${failure.message}");
      },
      (message) {
        debugPrint(message);
        state = state.where((a) => a.addressId != address.addressId).toList();
      },
    );
  }
}
