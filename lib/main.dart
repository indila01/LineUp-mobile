import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:line_up_mobile/models/app_state.dart';
import 'package:line_up_mobile/redux/actions.dart';
import 'package:line_up_mobile/redux/reducers.dart';
import 'package:line_up_mobile/screens/batch_lectures_screen.dart';
import 'package:line_up_mobile/screens/home_screen.dart';
import 'package:line_up_mobile/screens/calender.dart';
import 'package:line_up_mobile/screens/login_screen.dart';
import 'package:line_up_mobile/screens/profile_screen.dart';
import 'package:line_up_mobile/screens/schedule_timetable_screen.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final store = Store<AppState>(appRudecer,
      initialState: AppState.initial(),
      middleware: [thunkMiddleware, LoggingMiddleware.printer()]);
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'Line up',
          routes: {
            '/home': (BuildContext context) => HomeScreen(onInit: () {
                  StoreProvider.of<AppState>(context).dispatch(getUserAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getBatchesAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getSubjectsAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getStudentsAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getProfileAction);
                }),
            '/login': (BuildContext context) => LoginScreen(),
            '/profile': (BuildContext context) => ProfileScreen(),
            '/lectures': (BuildContext context) => BatchLecturesScreen(),
            '/classroomform': (BuildContext context) =>
                ScheduleTimeTableScreen()
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.amber[700],
              primarySwatch: Colors.blue,
              accentColor: Colors.lightBlue[500],
              textTheme: TextTheme(
                  headline1: TextStyle(
                    fontSize: 72.0,
                    fontWeight: FontWeight.bold,
                  ),
                  headline2:
                      TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                  bodyText1: TextStyle(fontSize: 18.0))),
          home: LoginScreen(),
        ));
  }
}
