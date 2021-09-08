import 'dart:convert';

List<Batch> welcomeFromJson(String str) =>
    List<Batch>.from(json.decode(str).map((x) => Batch.fromJson(x)));

String welcomeToJson(List<Batch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Batch {
  int id;
  String batchCode;
  String course;
  String year;
  dynamic subjects;

  Batch({
    required this.id,
    required this.batchCode,
    required this.course,
    required this.year,
    required this.subjects,
  });

  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(
        id: json["id"],
        batchCode: json["batchCode"],
        course: json["course"],
        year: json["year"],
        subjects: json["subjects"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "batchCode": batchCode,
        "course": course,
        "year": year,
        "subjects": subjects,
      };
}
