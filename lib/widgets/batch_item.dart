import 'package:flutter/material.dart';
import 'package:line_up_mobile/models/batch.dart';

class BatchItem extends StatelessWidget {
  final Batch item;

  BatchItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Text(item.batchCode);
  }
}
