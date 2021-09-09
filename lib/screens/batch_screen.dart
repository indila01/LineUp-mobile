import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:line_up_mobile/models/app_state.dart';
import 'package:line_up_mobile/widgets/batch_item.dart';

class BatchScreen extends StatefulWidget {
  final void Function() onInit;
  BatchScreen({required this.onInit});

  @override
  _BatchScreenState createState() => _BatchScreenState();
}

class _BatchScreenState extends State<BatchScreen> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  final _appBar = PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return AppBar(
            centerTitle: true,
            title: SizedBox(
              child: state.user != null ? Text(state.user.username) : Text(''),
            ),
            leading: Icon(Icons.school),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: state.user != null
                      ? IconButton(
                          icon: Icon(Icons.exit_to_app),
                          onPressed: () => print('logout'))
                      : Text(''))
            ],
          );
        },
      ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar,
        body: Container(
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
                    itemBuilder: (context, i) =>
                        BatchItem(item: state.batches[i]),
                  ),
                ))
              ],
            );
          },
        )));
  }
}
