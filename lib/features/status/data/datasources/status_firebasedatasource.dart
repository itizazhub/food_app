import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/status/data/models/status_model.dart';

import 'package:http/http.dart' as http;

class StatusFirebasedatasource {
  final _baseUrl =
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app";
  Map<String, String> get _headers => {
        "Content-Type": "application/json",
      };

  Future<Either<Failure, List<StatusModel>>> getStatuses(
      {required String status}) async {
    final url = Uri.https(
      _baseUrl,
      "status.json",
    );

    try {
      final response = await http.get(url, headers: _headers);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        return Right(result.entries
            .map((statusJson) => StatusModel.fromJson(
                key: statusJson.key, json: statusJson.value))
            .toList());
      } else {
        return Left(SomeSpecificError(
            "Failed to fetch status: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(
          SomeSpecificError("Exception in getStatuses: ${e.toString()}"));
    }
  }
}
