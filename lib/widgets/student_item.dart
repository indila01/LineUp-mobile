import 'package:flutter/material.dart';
import 'package:line_up_mobile/models/profile.dart';

class StudentItem extends StatelessWidget {
  final Profile item;

  StudentItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.blue.withAlpha(40),
        child: ExpansionTile(
          leading: Icon(Icons.people_outline),
          title: Text(item.username),
          subtitle: Text(item.email),
          children: <Widget>[
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('Name : ${item.firstName} ${item.lastName}'),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('Email : ${item.email}'),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('Batch : ${item.batch}'),
            ),
          ],
        ));
  }
}
