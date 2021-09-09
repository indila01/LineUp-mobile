import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:line_up_mobile/models/app_state.dart';
import 'package:line_up_mobile/widgets/subject_item.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({Key? key}) : super(key: key);

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
                itemCount: state.subjects.length,
                itemBuilder: (context, i) =>
                    SubjectItem(item: state.subjects[i]),
              ),
            ))
          ],
        );
      },
    ));
  }
}
