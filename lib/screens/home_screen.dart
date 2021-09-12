import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:line_up_mobile/models/app_state.dart';
import 'package:line_up_mobile/redux/actions.dart';
import 'package:line_up_mobile/screens/batch_screen.dart';
import 'package:line_up_mobile/screens/schedule_timetable_screen.dart';
import 'package:line_up_mobile/screens/student_screen.dart';
import 'package:line_up_mobile/screens/subject_screen.dart';
import 'package:line_up_mobile/screens/timetable_screen.dart';

class HomeScreen extends StatefulWidget {
  final void Function() onInit;
  HomeScreen({required this.onInit});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    BatchScreen(),
    SubjectScreen(),
    TimeTableScreen(),
    StudentScreen()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  final _appBar = PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return AppBar(
            centerTitle: true,
            title: SizedBox(
              child: state.user != null ? Text(state.user.username) : Text(''),
            ),
            leading: state.user != null
                ? IconButton(
                    onPressed: () => Navigator.pushNamed(context, '/profile'),
                    icon: Icon(Icons.person))
                : Text(''),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: StoreConnector<AppState, VoidCallback>(
                      converter: (store) {
                    return () => {
                          store.dispatch(logoutUserAction),
                          Navigator.pushReplacementNamed(context, '/login')
                        };
                  }, builder: (_, callback) {
                    return state.user != null
                        ? IconButton(
                            icon: Icon(Icons.exit_to_app), onPressed: callback)
                        : Text('');
                  }))
            ],
          );
        },
      ));
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (_, state) {
              return Scaffold(
                  appBar: _appBar,
                  body: _children[_currentIndex],
                  bottomNavigationBar: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.school),
                        label: 'Batches',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.auto_stories,
                        ),
                        label: 'Subjects',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.event_available,
                        ),
                        label: 'TimeTable',
                      ),
                      if (state.user != null && state.user.role != 'STUDENT')
                        (BottomNavigationBarItem(
                          icon: Icon(
                            Icons.people,
                          ),
                          label: 'students',
                        )),
                    ],
                    currentIndex: _currentIndex,
                    selectedItemColor: Colors.amber[800],
                    onTap: onTabTapped,
                  ));
            }));
  }
}
