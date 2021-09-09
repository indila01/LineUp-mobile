import 'package:flutter/material.dart';
import 'package:line_up_mobile/models/batch.dart';

class BatchItem extends StatelessWidget {
  final Batch item;

  BatchItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.school_outlined),
              title: Text('${item.batchCode} (${item.year})'),
              subtitle: Text(item.course),
            ),
          ],
        ),
      ),
    );
  }
}
