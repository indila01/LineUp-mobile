import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:line_up_mobile/models/app_state.dart';
import 'package:line_up_mobile/widgets/classroom_item.dart';

class BatchLecturesScreen extends StatelessWidget {
  const BatchLecturesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classes'),
        centerTitle: true,
      ),
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return Column(
            children: [
              Expanded(
                  child: SafeArea(
                top: false,
                bottom: false,
                child: ListView.builder(
                  itemCount: state.classrooms.length,
                  itemBuilder: (context, i) =>
                      ClassroomItem(item: state.classrooms[i]),
                ),
              ))
            ],
          );
        },
      ),
    );
  }
}
