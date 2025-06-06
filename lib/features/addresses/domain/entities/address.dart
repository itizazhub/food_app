class Address {
  Address(
      {required this.addressId, required this.userId, required this.address});

  String addressId;
  String userId;
  String address;

  Address copyWith({String? addressId, String? userId, String? address}) {
    return Address(
        addressId: addressId ?? this.address,
        userId: userId ?? this.userId,
        address: address ?? this.address);
  }
}
