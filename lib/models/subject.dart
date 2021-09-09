import 'dart:convert';

List<Subject> welcomeFromJson(String str) =>
    List<Subject>.from(json.decode(str).map((x) => Subject.fromJson(x)));

String welcomeToJson(List<Subject> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subject {
  int id;
  String name;
  String lecturer;

  Subject({
    required this.id,
    required this.name,
    required this.lecturer,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(id: json["id"], name: json["name"], lecturer: json["user"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user": lecturer,
      };
}
