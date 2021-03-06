import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:line_up_mobile/models/app_state.dart';
import 'package:line_up_mobile/widgets/batch_item.dart';

class BatchScreen extends StatelessWidget {
  const BatchScreen({Key? key}) : super(key: key);

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
                itemCount: state.batches.length,
                itemBuilder: (context, i) => BatchItem(item: state.batches[i]),
              ),
            ))
          ],
        );
      },
    ));
  }
}
