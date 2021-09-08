import 'dart:convert';

UserModel welcomeFromJson(String str) => UserModel.fromJson(json.decode(str));

String welcomeToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.username,
    required this.role,
    required this.token,
  });

  final String username;
  final String role;
  final String token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        role: json["role"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "role": role,
        "token": token,
      };
}
