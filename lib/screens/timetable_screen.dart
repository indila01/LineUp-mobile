import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:line_up_mobile/constants/Strings.dart';
import 'package:http/http.dart' as http;
import 'package:line_up_mobile/models/app_state.dart';
import 'package:line_up_mobile/models/batch.dart';
import 'package:line_up_mobile/models/subject.dart';
import 'package:line_up_mobile/redux/actions.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({Key? key}) : super(key: key);

  @override
  _TimeTableScreenState createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  TextEditingController dateinput = TextEditingController();

  String? _classname, _batch, _date, _startTime, _endTime;
  bool? _isSubmitting;

  Widget _showBatchInput(state) {
    List<Batch> batches = state.batches;
    List<String> batchList = batches.map((Batch b) => b.batchCode).toList();
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: DropdownButtonFormField(
        validator: (val) => val == null ? 'Select batch' : null,
        value: _batch,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Batch',
          hintText: 'Enter batch',
        ),
        items: batchList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _batch = value.toString();
          });
        },
      ),
    );
  }

  Widget _showDateInput(state) {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
          readOnly: true,
          onSaved: (val) => _date = val!,
          validator: (val) => val!.length < 1 ? 'Invalid Date ' : null,
          controller: dateinput,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime
                    .now(), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2101));

            pickedDate != null
                ? setState(() {
                    dateinput.text =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                  })
                : setState(() {
                    dateinput.text = '';
                  });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Date',
            hintText: 'Enter Date',
          ),
        ));
  }

  Widget _showFormActions() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, callback) {
            return ElevatedButton(
              child: Text(
                'Search',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.black),
              ),
              onPressed: _submit,
            );
          },
        ));
  }

  Widget _showCreateClassroomButton() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          ElevatedButton(
            child: Text(
              'Create classroom',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.black),
            ),
            onPressed: () => Navigator.pushNamed(context, '/classroomform'),
          )
        ],
      ),
    );
  }

  void _submit() async {
    final store = StoreProvider.of<AppState>(context);
    final form = _formkey.currentState;

    if (form!.validate()) {
      form.save();
      await store.dispatch(batchTimeTableDateAction(context, _batch!, _date!));
      Navigator.pushNamed(context, '/lectures');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
            child: SingleChildScrollView(
          child: Form(
              key: _formkey,
              child: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) {
                  return Column(
                    children: [
                      if (state.user != null && state.user.role != 'STUDENT')
                        _showCreateClassroomButton(),
                      Text(
                        'Search classrooms',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      _showBatchInput(state),
                      _showDateInput(state),
                      _showFormActions(),
                    ],
                  );
                },
              )),
        )),
      ),
    );
  }
}
