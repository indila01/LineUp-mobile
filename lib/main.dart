import 'package:flutter/material.dart';
import 'package:line_up_mobile/screens/batch_screen.dart';
import 'package:line_up_mobile/screens/calender.dart';
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
      routes: {
        '/batches': (BuildContext context) => BatchScreen(),
        '/login': (BuildContext context) => LoginScreen()
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.amber[600],
          primarySwatch: Colors.blue,
          accentColor: Colors.lightBlue[500],
          textTheme: TextTheme(
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline2: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              bodyText1: TextStyle(fontSize: 18.0))),
      home: LoginScreen(),
    );
  }
}
