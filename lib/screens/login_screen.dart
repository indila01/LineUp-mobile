import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:line_up_mobile/constants/Strings.dart';
// import 'package:line_up_mobile/services/lineup_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  String? _username, _password;
  bool? _isSubmitting;
  bool _obscureText = true;
  Widget _showLogo() {
    return Image(
        height: MediaQuery.of(context).size.height / 5,
        width: 100,
        fit: BoxFit.contain,
        image: AssetImage('assets/images/time-management.png'));
  }

  Widget _showUsernameInput() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
          onSaved: (val) => _username = val!,
          validator: (val) => val!.length < 1 ? 'username too short' : null,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
              hintText: 'Enter Username',
              icon: Icon(Icons.face, color: Colors.grey)),
        ));
  }

  Widget _showPasswordInput() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
          onSaved: (val) => _password = val!,
          validator: (val) => val!.length < 1 ? 'password too short' : null,
          obscureText: _obscureText,
          decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() => _obscureText = !_obscureText);
                },
                child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
              ),
              border: OutlineInputBorder(),
              labelText: 'Password',
              hintText: 'Enter password',
              icon: Icon(Icons.lock, color: Colors.grey)),
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
      _loginUser();
    }
  }

  void _loginUser() async {
    setState(() => _isSubmitting = true);

    var url = Uri.parse('${Strings.baseUrl}/api/login');
    http.Response response = await http.post(url,
        body: jsonEncode({"username": _username, "password": _password}),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() => _isSubmitting = false);
      _storeUserData(responseData);
      _showSuccessSnack();
      _redirectUser();
      // print(responseData);
    } else {
      setState(() => _isSubmitting = false);
      final String errorMsg = 'Error login';

      _showErrorSnack(errorMsg);
    }
  }

  void _storeUserData(responseData) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> user = responseData;

    prefs.setString('user', json.encode(user));
  }

  void _showSuccessSnack() {
    final snackBar = SnackBar(
        content: Text('Success login', style: TextStyle(color: Colors.green)));
    // _scafoldKey.currentState!.showSnackBar(snackBar);
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(snackBar);

    _formkey.currentState!.reset();
  }

  void _showErrorSnack(String errorMsg) {
    final snackBar =
        SnackBar(content: Text(errorMsg, style: TextStyle(color: Colors.red)));
    // _scafoldKey.currentState!.showSnackBar(snackBar);
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(snackBar);

    throw Exception('Error auth');
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text('Sign In'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
            child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                _showLogo(),
                _showUsernameInput(),
                _showPasswordInput(),
                _showFormActions(),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
