import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:line_up_mobile/constants/Strings.dart';
import 'package:line_up_mobile/models/app_state.dart';
import 'package:line_up_mobile/models/batch.dart';
import 'package:line_up_mobile/models/user.dart';
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

class GetUserAction {
  final User _user;

  User get user => this._user;

  GetUserAction(this._user);
}

// batches Actions
ThunkAction<AppState> getBatchesAction = (Store<AppState> store) async {
  var url = Uri.parse('${Strings.baseUrl}/api/batches');
  http.Response response = await http.get(url);

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
