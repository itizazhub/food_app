import 'package:food_app/features/status/domain/entities/status.dart';

class StatusModel {
  StatusModel({
    required this.statusId,
    required this.status,
  });
  String statusId;
  String status;

  factory StatusModel.fromJson(
      {required key, required Map<String, dynamic> json}) {
    return StatusModel(statusId: key, status: json["name"]);
  }
  factory StatusModel.fromEntity({required Status status}) {
    return StatusModel(statusId: status.statusId, status: status.status);
  }
  Status toEntity() {
    return Status(statusId: statusId, status: status);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": status,
    };
  }

  StatusModel copywith({String? statusId, String? status}) {
    return StatusModel(
        statusId: statusId ?? this.statusId, status: status ?? this.status);
  }
}
