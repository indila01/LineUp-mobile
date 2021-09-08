// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:line_up_mobile/constants/Strings.dart';
// import 'package:line_up_mobile/models/batch.dart';
// import 'package:line_up_mobile/models/user.dart';

// class APIService {
//   APIService();

//   Future<UserModel> auth() async {
//     var userModel;
//     var url = Uri.parse('${Strings.baseUrl}/users/auth');

//     final response = await http.post(url,
//         body: {"email": "indiladineth@yahoo.com", "password": "indila"});

//     if (response.statusCode == 200) {
//       var jsonString = response.body;
//       var jsonMap = json.decode(jsonString);

//       userModel = UserModel.fromJson(jsonMap);
//       return userModel;
//     }
//     print(response.statusCode);
//     throw response;
//   }

//   Future<List<BatchModel>> getBatches() async {
//     var client = http.Client();
//     var url = Uri.parse('${Strings.baseUrl}/api/batches');

//     var response = await client.get(url);

//     if (response.statusCode == 200) {
//       var jsonString = response.body;
//       Iterable jsonMap = json.decode(jsonString);

//       List<BatchModel> batchModels = List<BatchModel>.from(
//           jsonMap.map((model) => BatchModel.fromJson(model)));

//       return batchModels;
//     } else {
//       throw Exception("Failed to load");
//     }
//   }
// }
