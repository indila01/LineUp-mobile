import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:line_up_mobile/models/batch.dart';
import 'package:line_up_mobile/services/lineup_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BatchScreen extends StatefulWidget {
  const BatchScreen({Key? key}) : super(key: key);

  @override
  _BatchScreenState createState() => _BatchScreenState();
}

class _BatchScreenState extends State<BatchScreen> {
  // Future<List<BatchModel>>? _batchModel;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  _getUser() async {
    final prefs = await SharedPreferences.getInstance();
    var storedUser = prefs.getString('user');
    print(json.decode(storedUser!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Batches'),
        ),
        body: Container(
            child: FutureBuilder<List<BatchModel>>(
                future: APIService().getBatches(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          var batch = snapshot.data![index];
                          return Container(
                            height: 100,
                            child: Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.batch_prediction),
                                    title: Text(
                                        '${batch.batchCode} (${batch.year})'),
                                    subtitle: Text(batch.course),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })));
  }
}
