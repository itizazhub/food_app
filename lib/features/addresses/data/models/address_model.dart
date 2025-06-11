import 'package:food_app/features/addresses/domain/entities/address.dart';

class AddressModel {
  AddressModel({
    required this.addressId,
    required this.userId,
    required this.address,
  });

  String addressId;
  String userId;
  String address;

  factory AddressModel.fromJson({
    required String key,
    required Map<String, dynamic> json,
  }) {
    return AddressModel(
      addressId: key,
      userId: json["user_id"],
      address: json["address_line"],
    );
  }

  factory AddressModel.fromEntity({
    required Address address,
  }) {
    return AddressModel(
        addressId: address.addressId,
        userId: address.userId,
        address: address.address);
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "address_line": address,
    };
  }

  Address toEntity() {
    return Address(
      addressId: addressId,
      userId: userId,
      address: address,
    );
  }

  AddressModel copyWith({
    String? addressId,
    String? userId,
    String? address,
  }) {
    return AddressModel(
        addressId: addressId ?? this.address,
        userId: userId ?? this.userId,
        address: address ?? this.address);
  }
}
