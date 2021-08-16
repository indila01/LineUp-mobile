import 'package:flutter/material.dart';
import 'package:line_up_mobile/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Line up',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(255, 191, 59, 1),
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
