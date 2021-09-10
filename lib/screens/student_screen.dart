import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:line_up_mobile/models/app_state.dart';
import 'package:line_up_mobile/widgets/student_item.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return Column(
          children: [
            Expanded(
                child: SafeArea(
              top: false,
              bottom: false,
              child: ListView.builder(
                itemCount: state.students.length,
                itemBuilder: (context, i) =>
                    StudentItem(item: state.students[i]),
              ),
            ))
          ],
        );
      },
    ));
  }
}
