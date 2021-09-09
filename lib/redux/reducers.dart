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

User userReducer(user, action) {
  if (action is GetUserAction) {
    //return the user from action
    return action.user;
  }
  return user;
}

List<Batch> batchesReducer(batches, action) {
  if (action is GetBatchesAction) {
    //return the user from action
    return action.batches;
  }
  return batches;
}

List<Subject> subjectsReducer(subjects, action) {
  if (action is GetSubjectsAction) {
    //return the subjects from action
    return action.subjects;
  }
  return subjects;
}

Profile profileReducer(profile, action) {
  if (action is GetProfileAction) {
    //return the user from action
    return action.profile;
  }
  return profile;
}
