import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:line_up_mobile/constants/Strings.dart';
import 'package:line_up_mobile/models/app_state.dart';
import 'package:line_up_mobile/models/subject.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:line_up_mobile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleTimeTableScreen extends StatefulWidget {
  ScheduleTimeTableScreen({Key? key}) : super(key: key);

  @override
  _ScheduleTimeTableScreenState createState() =>
      _ScheduleTimeTableScreenState();
}

class _ScheduleTimeTableScreenState extends State<ScheduleTimeTableScreen> {
  final _formkey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  TextEditingController dateinput = TextEditingController();
  TextEditingController startTimeInput = TextEditingController();
  TextEditingController endTimeInput = TextEditingController();

  String? _classname, _subject, _date, _startTime, _endTime;
  bool? _isSubmitting;

  Widget _showClassnameInput(state) {
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

  Widget _showStartTimeInput(state) {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
          readOnly: true,
          onSaved: (val) => _startTime = val!,
          validator: (val) => val!.length < 1 ? 'Invalid start time' : null,
          controller: startTimeInput,
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());
            pickedTime != null
                ? setState(() {
                    startTimeInput.text = DateFormat("HH:mm").format(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        pickedTime.hour,
                        pickedTime.minute));
                  })
                : setState(() {
                    startTimeInput.text = '';
                  });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Start time',
            hintText: 'Enter Start time',
          ),
        ));
  }

  Widget _showEndTimeInput(state) {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
          readOnly: true,
          onSaved: (val) => _endTime = val!,
          validator: (val) => val!.length < 1 ? 'Invalid end time' : null,
          controller: endTimeInput,
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());
            pickedTime != null
                ? setState(() {
                    endTimeInput.text = DateFormat("HH:mm").format(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        pickedTime.hour,
                        pickedTime.minute));
                  })
                : setState(() {
                    endTimeInput.text = '';
                  });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'End time',
            hintText: 'Invalid end time',
          ),
        ));
  }

  Widget _showSubjectInput(state) {
    List<Subject> subjects = state.subjects;
    List<String> subjectlist = subjects.map((Subject s) => s.name).toList();
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: DropdownButtonFormField(
        validator: (val) => val == null ? 'Select subject' : null,
        value: _subject,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Subject',
          hintText: 'Enter subject ',
        ),
        items: subjectlist.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _subject = value.toString();
          });
        },
      ),
    );
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
                    'Schedule class',
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

  void _submit() {
    final form = _formkey.currentState;

    if (form!.validate()) {
      form.save();
      _createClassroom();
    }
  }

  void _createClassroom() async {
    setState(() => _isSubmitting = true);
    final prefs = await SharedPreferences.getInstance();
    final String? storedUser = prefs.getString('user');

    if (storedUser != null) {
      final User user = User.fromJson(json.decode(storedUser));

      var url = Uri.parse('${Strings.baseUrl}/api/classrooms/create');
      http.Response response = await http.post(url,
          body: jsonEncode({
            "className": _classname,
            "startTime": _startTime,
            "endTime": _endTime,
            "date": _date,
            "subject": _subject
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${user.token}'
          });
      if (response.statusCode == 200) {
        final responseData = response.body;
        setState(() => _isSubmitting = false);
        _showSuccessSnack();
        _redirectUser();
        print(responseData);
      } else {
        setState(() => _isSubmitting = false);
        final String errorMsg = 'Error Creating Schedule';

        _showErrorSnack(errorMsg);
      }
    } else {
      setState(() => _isSubmitting = false);
      final String errorMsg = 'Error Creating Schedule';

      _showErrorSnack(errorMsg);
    }
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
      appBar: AppBar(title: Text('Schedule class')),
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
                      Text(
                        'Schedule classroom',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      _showClassnameInput(state),
                      _showDateInput(state),
                      _showStartTimeInput(state),
                      _showEndTimeInput(state),
                      _showSubjectInput(state),
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
