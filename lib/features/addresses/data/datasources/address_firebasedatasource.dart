import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:food_app/features/addresses/data/models/address_model.dart';
import 'package:food_app/features/addresses/domain/entities/address.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:http/http.dart' as http;

class AddressFirebasedatasource {
  Future<Either<Failure, List<AddressModel>>> getUserAddresses(
      {required User user}) async {
    final url = Uri.https(
        "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
        "addresses.json");
    try {
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Get users request status code ${response.statusCode}");

        Map<String, dynamic> result = jsonDecode(response.body);

        List<AddressModel> allAddresses = result.entries.map((jsonUser) {
          return AddressModel.fromJson(key: jsonUser.key, json: jsonUser.value);
        }).toList();

        List<AddressModel> userAddresses = allAddresses.where((address) {
          return address.userId == user.id;
        }).toList();

        return Right(userAddresses);
      } else {
        return Left(SomeSpecificError(
            "Get address request error status code ${response.statusCode}"));
      }
    } catch (e) {
      return Left(
          SomeSpecificError("Get address request Something bad happened $e"));
    }
  }

  Future<Either<Failure, String>> removeUserAddress({
    required Address address,
  }) async {
    final url = Uri.https(
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
      "addresses/${address.addressId}.json",
    );

    try {
      final response = await http.delete(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("User address removed successfully: ${response.statusCode}");
        return Right("User address removed successfully");
      } else {
        return Left(SomeSpecificError(
            "Failed to remove address. Status code: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(
          SomeSpecificError("Exception occurred while removing address: $e"));
    }
  }

  Future<Either<Failure, AddressModel>> addUserAddress(
      {required Address address}) async {
    final url = Uri.https(
        "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
        "addresses.json");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(AddressModel.fromEntity(address: address).toJson()),
      );

      final result = json.decode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Post user  address added successfully ${response.statusCode}");

        return Right(AddressModel.fromEntity(address: address)
            .copyWith(addressId: result["name"]));
      } else {
        return Left((SomeSpecificError(
            "Can not add user address ${response.statusCode}")));
      }
    } catch (e) {
      return Left((SomeSpecificError("Can not add user address $e")));
    }
  }
}
