import 'package:line_up_mobile/models/app_state.dart';
import 'package:line_up_mobile/models/batch.dart';
import 'package:line_up_mobile/models/classroom.dart';
import 'package:line_up_mobile/models/profile.dart';
import 'package:line_up_mobile/models/subject.dart';
import 'package:line_up_mobile/models/user.dart';
import 'package:line_up_mobile/redux/actions.dart';

AppState appRudecer(AppState state, dynamic action) {
  return AppState(
      user: userReducer(state.user, action),
      batches: batchesReducer(state.batches, action),
      subjects: subjectsReducer(state.subjects, action),
      students: studentsReducer(state.students, action),
      profile: profileReducer(state.profile, action),
      classrooms: classroomsReducer(state.classrooms, action));
}

User? userReducer(User? user, dynamic action) {
  if (action is GetUserAction) {
    //return the user from action
    return action.user;
  } else if (action is LogoutUserAction) {
    return action.user;
  }
  return user;
}

List<Batch> batchesReducer(List<Batch> batches, dynamic action) {
  if (action is GetBatchesAction) {
    //return the user from action
    return action.batches;
  }
  return batches;
}

List<Subject> subjectsReducer(List<Subject> subjects, dynamic action) {
  if (action is GetSubjectsAction) {
    //return the subjects from action
    return action.subjects;
  }
  return subjects;
}

Profile? profileReducer(Profile? profile, dynamic action) {
  if (action is GetProfileAction) {
    //return the user from action
    return action.profile;
  }
  return profile;
}

List<Profile> studentsReducer(List<Profile> students, dynamic action) {
  if (action is GetStudentsAction) {
    //return the students from action
    return action.students;
  } else if (action is LogoutUserAction) {
    return [];
  }
  return students;
}

List<Classroom> classroomsReducer(List<Classroom> classrooms, dynamic action) {
  if (action is GetClassroomsAction) {
    //return the students from action
    return action.classrooms;
  }
  return classrooms;
}
