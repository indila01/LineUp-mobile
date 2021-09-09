class Profile {
  int id;
  String firstName;
  String lastName;
  String username;
  dynamic password;
  String email;
  String role;
  dynamic batch;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
    required this.email,
    required this.role,
    required this.batch,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      username: json["username"],
      password: json["password"],
      email: json["email"],
      role: json["role"],
      batch: json["batch"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "password": password,
        "email": email,
        "role": role,
        "batch": batch,
      };
}
