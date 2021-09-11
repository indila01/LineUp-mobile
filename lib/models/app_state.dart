import 'package:flutter/material.dart';
import 'package:line_up_mobile/models/batch.dart';
import 'package:line_up_mobile/models/classroom.dart';
import 'package:line_up_mobile/models/profile.dart';
import 'package:line_up_mobile/models/subject.dart';

@immutable
class AppState {
  final dynamic user;
  final List<Batch> batches;
  final List<Subject> subjects;
  final List<Profile> students;
  final dynamic profile;
  final List<Classroom> classrooms;
  AppState(
      {@required this.user,
      required this.batches,
      required this.subjects,
      required this.students,
      required this.profile,
      required this.classrooms});

  factory AppState.initial() {
    return AppState(
        user: null,
        batches: [],
        subjects: [],
        students: [],
        profile: null,
        classrooms: []);
  }
}
