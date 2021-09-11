import 'package:flutter/material.dart';
import 'package:line_up_mobile/models/classroom.dart';

class ClassroomItem extends StatelessWidget {
  final Classroom item;

  ClassroomItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.blue.withAlpha(40),
        child: ExpansionTile(
          leading: Icon(Icons.event_available_outlined),
          title: Text(item.subject),
          subtitle: Text(item.date),
          children: <Widget>[
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('Lecturer : ${item.lecturer}'),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('Class : ${item.className}'),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('Start Time : ${item.startTime}'),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('End Time : ${item.endTime}'),
            ),
          ],
        ));
  }
}
