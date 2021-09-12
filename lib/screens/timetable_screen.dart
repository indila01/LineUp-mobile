import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:line_up_mobile/constants/Strings.dart';
import 'package:http/http.dart' as http;
import 'package:line_up_mobile/models/app_state.dart';
import 'package:line_up_mobile/models/subject.dart';

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
  String? _chosenValue;

  String? _classname, _subject, _date, _startTime, _endTime;
  bool? _isSubmitting;

  Widget _showBatchInput(state) {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
          onSaved: (val) => _classname = val!,
          validator: (val) => val!.length < 1 ? 'Classname too short' : null,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Classname',
            hintText: 'Enter classname',
          ),
        ));
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
          // onSaved: (val) => _date,
          // validator: (val) => val!.length < 1 ? 'Invalid Date' : null,
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
      child: Column(
        children: [
          _isSubmitting == true
              ? CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).accentColor),
                )
              : ElevatedButton(
                  child: Text(
                    'Search',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.black),
                  ),
                  onPressed: _submit,
                )
        ],
      ),
    );
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

  void _submit() {
    final form = _formkey.currentState;

    if (form!.validate()) {
      form.save();
      _updateProfile();
    }
  }

  void _updateProfile() async {
    // setState(() => _isSubmitting = true);

    // var url = Uri.parse('${Strings.baseUrl}/api/password');
    // http.Response response = await http.put(url,
    //     body: jsonEncode({"username": _username, "password": _password}),
    //     headers: {
    //       'Content-type': 'application/json',
    //       'Accept': 'application/json',
    //     });
    // if (response.statusCode == 200) {
    //   // final responseData = json.decode(response.body);
    //   setState(() => _isSubmitting = false);
    //   _showSuccessSnack();
    //   _redirectUser();
    //   // print(responseData);
    // } else {
    //   setState(() => _isSubmitting = false);
    //   final String errorMsg = 'Error Update password';

    //   _showErrorSnack(errorMsg);
    // }
  }

  void _showSuccessSnack() {
    final snackBar = SnackBar(
        content:
            Text('Schedule created', style: TextStyle(color: Colors.green)));
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(snackBar);

    _formkey.currentState!.reset();
  }

  void _showErrorSnack(String errorMsg) {
    final snackBar =
        SnackBar(content: Text(errorMsg, style: TextStyle(color: Colors.red)));
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(snackBar);

    throw Exception('Schedule create fail');
  }

  void _redirectUser() {
    Future.delayed(Duration(microseconds: 50), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
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
                        'Schedule classroom',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      _showBatchInput(state),
                      _showDateInput(state),
                      // _showStartTimeInput(state),
                      // _showEndTimeInput(state),
                      // _showSubjectInput(state),
                      // Text(state.subjects['name']),
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
