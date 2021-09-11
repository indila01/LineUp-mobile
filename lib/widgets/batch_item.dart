import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:line_up_mobile/models/app_state.dart';
import 'package:line_up_mobile/models/batch.dart';
import 'package:line_up_mobile/redux/actions.dart';

class BatchItem extends StatelessWidget {
  final Batch item;

  BatchItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
          child: StoreConnector<AppState, VoidCallback>(converter: (store) {
        return () => {
              store.dispatch(batchTimeTableAction(context, item.id)),
              Navigator.pushNamed(context, '/lectures')
            };
      }, builder: (_, callback) {
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
                  onTap: callback,
                ),
              ],
            ),
          ),
        );
      })),
    );
  }
}
