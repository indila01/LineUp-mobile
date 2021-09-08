import 'package:flutter/material.dart';
import 'package:line_up_mobile/models/batch.dart';

@immutable
class AppState {
  final dynamic user;
  final List<Batch> batches;

  AppState({@required this.user, required this.batches});

  factory AppState.initial() {
    return AppState(user: null, batches: []);
  }
}
