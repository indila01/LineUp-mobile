import 'package:flutter/material.dart';
import 'package:line_up_mobile/models/batch.dart';
import 'package:line_up_mobile/models/subject.dart';

class SubjectItem extends StatelessWidget {
  final Subject item;

  SubjectItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.auto_stories_outlined),
              title: Text(item.name),
              subtitle: Text(item.lecturer),
            ),
          ],
        ),
      ),
    );
  }
}
