import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:line_up_mobile/constants/Strings.dart';
import 'package:line_up_mobile/models/user.dart';

class APIService {
  APIService();

  Future<User> auth() async {
    var userModel;
    var url = Uri.parse('${Strings.baseUrl}/users/auth');

    final response = await http.post(url,
        body: {"email": "indiladineth@yahoo.com", "password": "indila"});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);

      userModel = User.fromJson(jsonMap);
      return userModel;
    }
    print(response.statusCode);
    throw response;
  }
}
