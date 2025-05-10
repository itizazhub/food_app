import 'package:food_app/features/auth/domain/entities/user.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.isAdmin,
  });
  String id;
  String username;
  String email;
  String password;
  bool isAdmin;

  factory UserModel.fromJson(String key, Map<String, dynamic> json) {
    return UserModel(
      id: key,
      username: json["username"],
      email: json["email"],
      password: json["password"],
      isAdmin: json["isAdmin"] ?? false,
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      email: user.email,
      password: user.password,
      isAdmin: user.isAdmin,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "isAdmin": isAdmin,
    };
  }

  User toEntity() {
    return User(
      id: id,
      username: username,
      email: email,
      password: password,
      isAdmin: isAdmin,
    );
  }
}
