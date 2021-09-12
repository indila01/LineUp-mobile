import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_up_mobile/constants/Strings.dart';
import 'package:line_up_mobile/models/app_state.dart';
import 'package:line_up_mobile/models/batch.dart';
import 'package:line_up_mobile/models/classroom.dart';
import 'package:line_up_mobile/models/profile.dart';
import 'package:line_up_mobile/models/subject.dart';
import 'package:line_up_mobile/models/user.dart';
import 'package:line_up_mobile/screens/batch_lectures_screen.dart';

import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

// user Actions
ThunkAction<AppState> getUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String? storedUser = prefs.getString('user');

  final user =
      storedUser != null ? User.fromJson(json.decode(storedUser)) : null;

  store.dispatch(GetUserAction(user!));
};

ThunkAction<AppState> logoutUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user');

  User? user;
  List<Profile>? students = [];

  store.dispatch(LogoutUserAction(
    user,
    students,
  ));
};

class GetUserAction {
  final User _user;

  User get user => this._user;

  GetUserAction(this._user);
}

class LogoutUserAction {
  final User? _user;
  final List<Profile>? _students;

  User? get user => this._user;
  List<Profile>? get students => this._students;

  LogoutUserAction(
    this._user,
    this._students,
  );
}

// batches Actions
ThunkAction<AppState> getBatchesAction = (Store<AppState> store) async {
//get token
  final prefs = await SharedPreferences.getInstance();
  final String? storedUser = prefs.getString('user');

  if (storedUser == null) {
    return;
  }

  final User user = User.fromJson(json.decode(storedUser));

  var url = Uri.parse('${Strings.baseUrl}/api/batches/all');

  http.Response response =
      await http.get(url, headers: {'Authorization': 'Bearer ${user.token}'});

  final List<dynamic> responseData = json.decode(response.body);
  List<Batch> batches = [];

  responseData.forEach((batchData) {
    final Batch batch = Batch.fromJson(batchData);
    batches.add(batch);
  });
  store.dispatch(GetBatchesAction(batches));
};

class GetBatchesAction {
  final List<Batch> _batches;

  List<Batch> get batches => this._batches;

  GetBatchesAction(this._batches);
}

// subject Actions
ThunkAction<AppState> getSubjectsAction = (Store<AppState> store) async {
  //get token
  final prefs = await SharedPreferences.getInstance();
  final String? storedUser = prefs.getString('user');

  if (storedUser == null) {
    return;
  }

  final User user = User.fromJson(json.decode(storedUser));

  var url = Uri.parse('${Strings.baseUrl}/api/subjects/all');

  http.Response response =
      await http.get(url, headers: {'Authorization': 'Bearer ${user.token}'});

  final List<dynamic> responseData = json.decode(response.body);
  List<Subject> subjects = [];

  responseData.forEach((subjectData) {
    final Subject subject = Subject.fromJson(subjectData);
    subjects.add(subject);
  });
  store.dispatch(GetSubjectsAction(subjects));
};

class GetSubjectsAction {
  final List<Subject> _subjects;

  List<Subject> get subjects => this._subjects;

  GetSubjectsAction(this._subjects);
}

// profile Actions
ThunkAction<AppState> getProfileAction = (Store<AppState> store) async {
  //get token
  final prefs = await SharedPreferences.getInstance();
  final String? storedUser = prefs.getString('user');

  if (storedUser == null) {
    return;
  }

  final User user = User.fromJson(json.decode(storedUser));
  var url = Uri.parse('${Strings.baseUrl}/api/profile');

  http.Response response =
      await http.get(url, headers: {'Authorization': 'Bearer ${user.token}'});

  final dynamic responseData = json.decode(response.body);
  final Profile profile = Profile.fromJson(responseData);

  store.dispatch(GetProfileAction(profile));
};

class GetProfileAction {
  final Profile _profile;

  Profile get profile => this._profile;
  // get profile => this._profile;

  GetProfileAction(this._profile);
}

//student actions
ThunkAction<AppState> getStudentsAction = (Store<AppState> store) async {
//get token
  final prefs = await SharedPreferences.getInstance();
  final String? storedUser = prefs.getString('user');

  if (storedUser == null) {
    return;
  }

  final User user = User.fromJson(json.decode(storedUser));

  //check if not student
  if (user.role == 'STUDENT') {
    return;
  }

  var url = Uri.parse('${Strings.baseUrl}/api/students/all');

  http.Response response =
      await http.get(url, headers: {'Authorization': 'Bearer ${user.token}'});

  final List<dynamic> responseData = json.decode(response.body);
  List<Profile> students = [];

  responseData.forEach((studentData) {
    final Profile student = Profile.fromJson(studentData);
    students.add(student);
  });
  store.dispatch(GetStudentsAction(students));
};

class GetStudentsAction {
  final List<Profile> _students;

  List<Profile> get students => this._students;

  GetStudentsAction(this._students);
}

//student actions
ThunkAction<AppState> batchTimeTableAction(BuildContext context, int id) {
//get tokenre
  return (Store<AppState> store) async {
    final prefs = await SharedPreferences.getInstance();
    final String? storedUser = prefs.getString('user');

    if (storedUser == null) {
      return;
    }

    final User user = User.fromJson(json.decode(storedUser));

    var url = Uri.parse('${Strings.baseUrl}/api/classrooms/bybatch/all/$id');

    http.Response response =
        await http.get(url, headers: {'Authorization': 'Bearer ${user.token}'});

    final List<dynamic> responseData = json.decode(response.body);
    List<Classroom> classrooms = [];

    responseData.forEach((classroomData) {
      final Classroom classroom = Classroom.fromJson(classroomData);
      classrooms.add(classroom);
    });
    store.dispatch(GetClassroomsAction(classrooms));
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => BatchLecturesScreen()));
    // Navigator.of(context).push(return batchle);
  };
}

class GetClassroomsAction {
  final List<Classroom> _classrooms;

  List<Classroom> get classrooms => this._classrooms;

  GetClassroomsAction(this._classrooms);
}
