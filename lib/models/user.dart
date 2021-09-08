import 'dart:convert';

User welcomeFromJson(String str) => User.fromJson(json.decode(str));

String welcomeToJson(User data) => json.encode(data.toJson());

class User {
  String username;
  String role;
  String token;

  User({
    required this.username,
    required this.role,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json["username"],
      role: json["role"],
      token: json["token"],
    );
  }
  Map<String, dynamic> toJson() => {
        "username": username,
        "role": role,
        "token": token,
      };
}
