class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String nic;
  final String licenseNumber;
  final int contactNumber;
  final bool isAdmin;
  final bool isBlacklisted;
  final bool isVerified;
  final String dob;
  final String token;

  User(
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.address,
    this.nic,
    this.licenseNumber,
    this.contactNumber,
    this.isAdmin,
    this.isBlacklisted,
    this.isVerified,
    this.dob,
    this.token,
  );

  User.fromJson(Map<String, dynamic> json)
      : id = json["_id"],
        firstName = json["firstName"],
        lastName = json["lastName"],
        email = json["email"],
        address = json["address"],
        nic = json["NIC"],
        licenseNumber = json["licenseNumber"],
        contactNumber = json["contactNumber"],
        isAdmin = json["isAdmin"],
        isBlacklisted = json["isBlacklisted"],
        isVerified = json["isVerified"],
        dob = json["DOB"],
        token = json["token"];

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "address": address,
        "NIC": nic,
        "licenseNumber": licenseNumber,
        "contactNumber": contactNumber,
        "isAdmin": isAdmin,
        "isBlacklisted": isBlacklisted,
        "isVerified": isVerified,
        "DOB": dob,
        "token": token,
      };
}
