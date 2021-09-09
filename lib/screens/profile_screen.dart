import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:line_up_mobile/constants/Strings.dart';
import 'package:http/http.dart' as http;
import 'package:line_up_mobile/models/app_state.dart';

class ProfileScreen extends StatefulWidget {
  final void Function() onInit;
  ProfileScreen({required this.onInit});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  final _formkey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  String? _username, _password;
  bool? _isSubmitting;
  bool _obscureText = true;

  // Widget _showUsernameInput() {
  //   return Padding(
  //       padding: EdgeInsets.only(top: 20.0),
  //       child: TextFormField(
  //         enabled: false,
  //         // initialValue: '$state.user',
  //         onSaved: (val) => _username = val!,
  //         validator: (val) => val!.length < 1 ? 'username too short' : null,
  //         decoration: InputDecoration(
  //             border: OutlineInputBorder(),
  //             labelText: 'Username',
  //             hintText: 'Enter Username',
  //             icon: Icon(Icons.face, color: Colors.grey)),
  //       ));
  // }

  // Widget _showPasswordInput() {
  //   return Padding(
  //       padding: EdgeInsets.only(top: 20.0),
  //       child: TextFormField(
  //         onSaved: (val) => _password = val!,
  //         validator: (val) => val!.length < 1 ? 'password too short' : null,
  //         obscureText: _obscureText,
  //         decoration: InputDecoration(
  //             suffixIcon: GestureDetector(
  //               onTap: () {
  //                 setState(() => _obscureText = !_obscureText);
  //               },
  //               child: Icon(
  //                   _obscureText ? Icons.visibility : Icons.visibility_off),
  //             ),
  //             border: OutlineInputBorder(),
  //             labelText: 'Password',
  //             hintText: 'Enter password',
  //             icon: Icon(Icons.lock, color: Colors.grey)),
  //       ));
  // }

  Widget _showFormActions() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          _isSubmitting == true
              ? CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).accentColor),
                )
              : ElevatedButton(
                  child: Text(
                    'Login',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.black),
                  ),
                  onPressed: _submit,
                )
        ],
      ),
    );
  }

  void _submit() {
    final form = _formkey.currentState;

    if (form!.validate()) {
      form.save();
      _updateProfile();
    }
  }

  void _updateProfile() async {
    setState(() => _isSubmitting = true);

    var url = Uri.parse('${Strings.baseUrl}/api/login');
    http.Response response = await http.post(url,
        body: jsonEncode({"username": _username, "password": _password}),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      // final responseData = json.decode(response.body);
      setState(() => _isSubmitting = false);
      _showSuccessSnack();
      _redirectUser();
      // print(responseData);
    } else {
      setState(() => _isSubmitting = false);
      final String errorMsg = 'Error login';

      _showErrorSnack(errorMsg);
    }
  }

  void _showSuccessSnack() {
    final snackBar = SnackBar(
        content:
            Text('Success Upadate', style: TextStyle(color: Colors.green)));
    // _scafoldKey.currentState!.showSnackBar(snackBar);
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(snackBar);

    _formkey.currentState!.reset();
  }

  void _showErrorSnack(String errorMsg) {
    final snackBar =
        SnackBar(content: Text(errorMsg, style: TextStyle(color: Colors.red)));
    // _scafoldKey.currentState!.showSnackBar(snackBar);
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(snackBar);

    throw Exception('Update fail');
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
            child: SingleChildScrollView(
          child: Form(
              key: _formkey,
              child: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) {
                  return Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            enabled: false,
                            initialValue: state.profile != null
                                ? state.profile.firstName
                                : '',
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'First Name',
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            enabled: false,
                            initialValue: state.profile != null
                                ? state.profile.lastName
                                : '',
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'last Name',
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            enabled: false,
                            initialValue: state.profile != null
                                ? state.profile.username
                                : '',
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username',
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            enabled: false,
                            initialValue: state.profile != null
                                ? state.profile.email
                                : '',
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          )),
                      if (state.user != null && state.user.role == 'STUDENT')
                        Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: TextFormField(
                              enabled: false,
                              initialValue: state.profile != null
                                  ? state.profile.batch
                                  : '',
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Batch',
                              ),
                            )),
                      Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            onSaved: (val) => _password = val!,
                            validator: (val) =>
                                val!.length < 1 ? 'password too short' : null,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Passowrd',
                              hintText: 'Change password',
                            ),
                          )),

                      // _showPasswordInput(),
                      _showFormActions(),
                    ],
                  );
                },
              )),
        )),
      ),
    );
  }
}
