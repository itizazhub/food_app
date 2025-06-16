class Status {
  Status({
    required this.statusId,
    required this.status,
  });
  String statusId;
  String status;

  Status copywith({String? statusId, String? status}) {
    return Status(
        statusId: statusId ?? this.statusId, status: status ?? this.status);
  }
}
