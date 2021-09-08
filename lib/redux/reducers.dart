import 'package:line_up_mobile/models/app_state.dart';
import 'package:line_up_mobile/models/batch.dart';
import 'package:line_up_mobile/models/user.dart';
import 'package:line_up_mobile/redux/actions.dart';

AppState appRudecer(AppState state, dynamic action) {
  return AppState(
      user: userReducer(state.user, action),
      batches: batchesReducer(state.batches, action));
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
