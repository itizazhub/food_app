import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/addresses/data/datasources/address_firebasedatasource.dart';
import 'package:food_app/features/addresses/data/repositories/address_repository_impl.dart';
import 'package:food_app/features/addresses/domain/entities/address.dart';
import 'package:food_app/features/addresses/domain/usecases/add_user_address.dart';
import 'package:food_app/features/addresses/domain/usecases/get_user_addresses.dart';
import 'package:food_app/features/addresses/domain/usecases/remove_user_address.dart';
import 'package:food_app/features/addresses/domain/usecases/update_user_address.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';

/// 🔌 Firebase Data Source Provider
final addressFirebaseDatasourceProvider =
    Provider<AddressFirebasedatasource>((ref) {
  return AddressFirebasedatasource();
});

/// 📦 Repository Provider
final addressRepositoryProvider = Provider<AddressRepositoryImpl>((ref) {
  return AddressRepositoryImpl(
    addressFirebasedatasource: ref.watch(addressFirebaseDatasourceProvider),
  );
});

/// ✅ Use Case Providers
final getUserAddressesProvider = Provider<GetUserAddresses>((ref) {
  return GetUserAddresses(
    addressRepository: ref.watch(addressRepositoryProvider),
  );
});

final addUserAddressProvider = Provider<AddUserAddress>((ref) {
  return AddUserAddress(
    addressRepository: ref.watch(addressRepositoryProvider),
  );
});

final removeUserAddressProvider = Provider<RemoveUserAddress>((ref) {
  return RemoveUserAddress(
    addressRepository: ref.watch(addressRepositoryProvider),
  );
});

final updateUserAddressProvider = Provider<UpdateUserAddress>((ref) {
  return UpdateUserAddress(
    addressRepository: ref.watch(addressRepositoryProvider),
  );
});

/// 🧠 Notifier Provider (State Management)
final addressNotifierProvider =
    StateNotifierProvider<AddressNotifier, List<Address>>((ref) {
  return AddressNotifier(
    getUserAddressesUseCase: ref.watch(getUserAddressesProvider),
    addUserAddressUseCase: ref.watch(addUserAddressProvider),
    removeUserAddressUseCase: ref.watch(removeUserAddressProvider),
    updateUserAddressUseCase: ref.watch(updateUserAddressProvider),
  );
});

/// 📘 Address Notifier Logic
class AddressNotifier extends StateNotifier<List<Address>> {
  final GetUserAddresses getUserAddressesUseCase;
  final AddUserAddress addUserAddressUseCase;
  final RemoveUserAddress removeUserAddressUseCase;
  final UpdateUserAddress updateUserAddressUseCase;

  AddressNotifier({
    required this.getUserAddressesUseCase,
    required this.addUserAddressUseCase,
    required this.removeUserAddressUseCase,
    required this.updateUserAddressUseCase,
  }) : super([]);

  /// 🔄 Fetch All Addresses for a User
  Future<void> getUserAddresses({required User user}) async {
    final result = await getUserAddressesUseCase(user: user);

    result.fold(
      (failure) {
        debugPrint("❌ Failed to fetch addresses: ${failure.message}");
        state = [];
      },
      (addresses) {
        state = addresses;
      },
    );
  }

  /// ➕ Add a New Address
  Future<void> addUserAddress({required Address address}) async {
    final result = await addUserAddressUseCase(address: address);

    result.fold(
      (failure) {
        debugPrint("❌ Failed to add address: ${failure.message}");
      },
      (addedAddress) {
        // Prevent duplicates based on address ID
        if (!state.any((a) => a.addressId == addedAddress.addressId)) {
          state = [...state, addedAddress];
        }
      },
    );
  }

  /// ➖ Remove an Address
  Future<void> removeUserAddress({required Address address}) async {
    final result = await removeUserAddressUseCase(address: address);

    result.fold(
      (failure) {
        debugPrint("❌ Failed to remove address: ${failure.message}");
      },
      (message) {
        debugPrint("✅ $message");
        state = state.where((a) => a.addressId != address.addressId).toList();
      },
    );
  }

  /// Update Address
  Future<void> updateUserAddress({required Address address}) async {
    final result = await updateUserAddressUseCase(address: address);

    result.fold(
      (failure) {
        debugPrint("❌ Failed to update address: ${failure.message}");
      },
      (updatedAddress) {
        final index =
            state.indexWhere((a) => a.addressId == updatedAddress.addressId);
        if (index != -1) {
          final updatedList = [...state];
          updatedList[index] = updatedAddress;
          state = updatedList;
          debugPrint("✅ Address updated successfully.");
        } else {
          debugPrint("⚠️ Address not found in current state.");
        }
      },
    );
  }
}
