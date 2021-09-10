import 'package:flutter/material.dart';
import 'package:line_up_mobile/models/profile.dart';

class StudentDetailsScreen extends StatelessWidget {
  final Profile? item;
  const StudentDetailsScreen({this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item!.username),
      ),
      body: Container(
        child: Column(
          children: [
            ListTile(
              title: Text(item!.username),
            ),
          ],
        ),
      ),
    );
  }
}
