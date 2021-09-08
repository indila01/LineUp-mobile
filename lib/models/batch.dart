import 'dart:convert';

List<BatchModel> welcomeFromJson(String str) =>
    List<BatchModel>.from(json.decode(str).map((x) => BatchModel.fromJson(x)));

String welcomeToJson(List<BatchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BatchModel {
  final int id;
  final String batchCode;
  final String course;
  final String year;
  final dynamic subjects;

  BatchModel({
    required this.id,
    required this.batchCode,
    required this.course,
    required this.year,
    required this.subjects,
  });

  factory BatchModel.fromJson(Map<String, dynamic> json) => BatchModel(
      id: json["id"],
      batchCode: json["batchCode"],
      course: json["course"],
      year: json["year"],
      subjects: json["subjects"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "batchCode": batchCode,
        "course": course,
        "year": year,
        "subjects": subjects,
      };
}
