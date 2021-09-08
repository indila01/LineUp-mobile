import 'package:line_up_mobile/models/app_state.dart';

AppState appRudecer(state, action) {
  return AppState(user: userReducer(state.user, action));
}

userReducer(user, action) {
  return user;
}
