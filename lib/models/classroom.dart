class Classroom {
  final int id;
  final String className;
  final String startTime;
  final String endTime;
  final String date;
  final String subject;
  final String lecturer;
  Classroom({
    required this.id,
    required this.className,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.subject,
    required this.lecturer,
  });

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      id: json["id"],
      className: json["className"],
      startTime: json["startTime"],
      endTime: json["endTime"],
      date: json["date"],
      subject: json["subject"],
      lecturer: json["lecturer"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "className": className,
        "startTime": startTime,
        "endTime": endTime,
        "date": date,
        "subject": subject,
        "lecturer": lecturer,
      };
}
