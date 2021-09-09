import 'package:flutter/material.dart';
import 'package:line_up_mobile/models/batch.dart';
import 'package:line_up_mobile/models/subject.dart';

@immutable
class AppState {
  final dynamic user;
  final List<Batch> batches;
  final List<Subject> subjects;
  final dynamic profile;

  AppState({
    @required this.user,
    required this.batches,
    required this.subjects,
    this.profile,
  });

  factory AppState.initial() {
    return AppState(user: null, batches: [], subjects: [], profile: null);
  }
}
