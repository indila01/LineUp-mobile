import 'package:line_up_mobile/models/app_state.dart';
import 'package:line_up_mobile/models/batch.dart';
import 'package:line_up_mobile/models/profile.dart';
import 'package:line_up_mobile/models/subject.dart';
import 'package:line_up_mobile/models/user.dart';
import 'package:line_up_mobile/redux/actions.dart';

AppState appRudecer(AppState state, dynamic action) {
  return AppState(
      user: userReducer(state.user, action),
      batches: batchesReducer(state.batches, action),
      subjects: subjectsReducer(state.subjects, action),
      profile: profileReducer(state.profile, action));
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
