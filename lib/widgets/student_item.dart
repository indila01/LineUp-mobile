import 'package:flutter/material.dart';
import 'package:line_up_mobile/models/profile.dart';
import 'package:line_up_mobile/screens/student_details_screen.dart';

class StudentItem extends StatelessWidget {
  final Profile item;

  StudentItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        child: InkWell(
            splashColor: Colors.blue.withAlpha(40),
            onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return StudentDetailsScreen(item: item);
                })),
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.school_outlined),
                  title: Text('${item.firstName} ${item.lastName}'),
                  subtitle: Text(item.batch),
                ),
              ],
            )),
      ),
    );
  }
}
