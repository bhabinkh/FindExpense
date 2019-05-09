import 'package:flutter/material.dart';
import 'dart:async';

var dateWidgetContainer = DateWidgetContainer();
var monthWidgetContainer = MonthWidgetContainer();
var yearWidgetContainer = YearWidgetContainer();

class DateWidgetContainer extends StatefulWidget {
  @override
  _DateWidgetContainerState createState() => _DateWidgetContainerState();
}

class _DateWidgetContainerState extends State<DateWidgetContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          dateWidgetContainer(context),
        ],
      ),
    );
  }

  dateWidgetContainer(context) {
    return Container(
        child: Card(
      color: Colors.green,
      child: ListTile(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {}),
        title: dateContainer(context),
        trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            color: Colors.black,
            onPressed: () {}),
      ),
    ));
  }

  dateContainer(context) {
    return Container(
      child: FlatButton(
        child: Row(
          children: <Widget>[
            Text(day(), textScaleFactor: 2.6),
            Padding(padding: EdgeInsets.only(left: 12.0)),
            Column(
              children: <Widget>[
                Text(
                  month() + "  " + "${_date.year}",
                ),
                Text(
                  weekDay(),
                )
              ],
            ),
          ],
        ),
        onPressed: () {
          _selectDate(context);
        },
      ),
    );
  }

  day() {
    if (_date.day.toString().length == 1)
      return "0${_date.day}";
    else
      return "${_date.day}";
  }

  month() {
    if (_date.month == 1)
      return "January";
    else if (_date.month == 2)
      return "February";
    else if (_date.month == 3)
      return "March";
    else if (_date.month == 4)
      return "April";
    else if (_date.month == 5)
      return "May";
    else if (_date.month == 6)
      return "June";
    else if (_date.month == 7)
      return "July";
    else if (_date.month == 8)
      return "August";
    else if (_date.month == 9)
      return "September";
    else if (_date.month == 10)
      return "October";
    else if (_date.month == 11)
      return "November";
    else
      return "December";
  }

  weekDay() {
    if (_date.weekday == 1)
      return "Monday";
    else if (_date.weekday == 2)
      return "Tuesday";
    else if (_date.weekday == 3)
      return "Wednesday";
    else if (_date.weekday == 4)
      return "Thursday";
    else if (_date.weekday == 5)
      return "Friday";
    else if (_date.weekday == 6)
      return "Saturday";
    else
      return "Sunday";
  }

  DateTime _date = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != _date) {
      // print('Date Selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }
}

class MonthWidgetContainer extends StatefulWidget {
  @override
  _MonthWidgetContainerState createState() => _MonthWidgetContainerState();
}

class _MonthWidgetContainerState extends State<MonthWidgetContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          monthWidgetContainer(context),
        ],
      ),
    );
  }

  monthWidgetContainer(context) {
    return Container(
        child: Card(
      color: Colors.green,
      child: ListTile(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {}),
        title: dateContainer(context),
        trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            color: Colors.black,
            onPressed: () {}),
      ),
    ));
  }

  dateContainer(context) {
    return Container(
      child: FlatButton(
        child: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 12.0)),
            Center(
              child:
                  Text(month() + "  " + "${_date.year}", textScaleFactor: 1.6),
            ),
          ],
        ),
        onPressed: () {
          _selectDate(context);
        },
      ),
    );
  }

  month() {
    if (_date.month == 1)
      return "January";
    else if (_date.month == 2)
      return "February";
    else if (_date.month == 3)
      return "March";
    else if (_date.month == 4)
      return "April";
    else if (_date.month == 5)
      return "May";
    else if (_date.month == 6)
      return "June";
    else if (_date.month == 7)
      return "July";
    else if (_date.month == 8)
      return "August";
    else if (_date.month == 9)
      return "September";
    else if (_date.month == 10)
      return "October";
    else if (_date.month == 11)
      return "November";
    else
      return "December";
  }

  DateTime _date = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != _date) {
      // print('Date Selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }
}

class YearWidgetContainer extends StatefulWidget {
  @override
  _YearWidgetContainerState createState() => _YearWidgetContainerState();
}

class _YearWidgetContainerState extends State<YearWidgetContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          yearWidgetContainer(context),
        ],
      ),
    );
  }

  yearWidgetContainer(context) {
    return Container(
        child: Card(
      color: Colors.green,
      child: ListTile(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {}),
        title: dateContainer(context),
        trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            color: Colors.black,
            onPressed: () {
              setState(() {
                _date.add(Duration(days: 365));
              });
            }),
      ),
    ));
  }

  dateContainer(context) {
    return Container(
      child: FlatButton(
        child: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 12.0)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("${_date.year}", textScaleFactor: 1.6),
              ],
            ),
          ],
        ),
        onPressed: () {
          _selectDate(context);
        },
      ),
    );
  }

  DateTime _date = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != _date) {
      // print('Date Selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }
}
