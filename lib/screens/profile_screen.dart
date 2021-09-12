import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:line_up_mobile/constants/Strings.dart';
import 'package:http/http.dart' as http;
import 'package:line_up_mobile/models/app_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  String? _username, _password;
  bool? _isSubmitting;
  bool _obscureText = true;

  Widget _showFirstNameInput(state) {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
          enabled: false,
          initialValue: state.profile != null ? state.profile.firstName : '',
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'First Name',
          ),
        ));
  }

  Widget _showLastNameInput(state) {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
          enabled: false,
          initialValue: state.profile != null ? state.profile.lastName : '',
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'last Name',
          ),
        ));
  }

  Widget _showUserNameInput(state) {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
          enabled: false,
          onSaved: (val) => _username = val!,
          initialValue: state.profile != null ? state.profile.username : '',
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Username',
          ),
        ));
  }

  Widget _showEmailInput(state) {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
          enabled: false,
          initialValue: state.profile != null ? state.profile.email : '',
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
          ),
        ));
  }

  Widget _showBatchInput(state) {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
          enabled: false,
          initialValue: state.profile != null ? state.profile.batch : '',
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Batch',
          ),
        ));
  }

  Widget _showPasswordInput(state) {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
          onSaved: (val) => _password = val!,
          validator: (val) => val!.length < 1 ? 'password too short' : null,
          obscureText: _obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Passowrd',
            hintText: 'Change password',
          ),
        ));
  }

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

    var url = Uri.parse('${Strings.baseUrl}/api/password');
    http.Response response = await http.put(url,
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
      final String errorMsg = 'Error Update password';

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
    Future.delayed(Duration(microseconds: 50), () {
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
                      _showFirstNameInput(state),
                      _showLastNameInput(state),
                      _showUserNameInput(state),
                      _showEmailInput(state),
                      if (state.user != null && state.user.role == 'STUDENT')
                        _showBatchInput(state),
                      _showPasswordInput(state),
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
