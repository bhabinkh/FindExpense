import 'package:flutter/material.dart';
import 'dart:async';
import 'Services/Service.dart';
import 'month_picker.dart';

var monthWidgetContainer = MonthWidgetContainer();

class DateWidgetContainer extends StatefulWidget {
  DateTime _date = DateTime.now();
  Function callBack;

  DateWidgetContainer(this.callBack, this._date);

  @override
  _DateWidgetContainerState createState() => _DateWidgetContainerState();
}

class _DateWidgetContainerState extends State<DateWidgetContainer> {
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: widget._date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != widget._date) {
      // print('Date Selected: ${_date.toString()}');
      setState(() {
        widget._date = picked;
        dateInternal = picked;
      });
    }

    Service().savePickedDate(picked).then((value) {
      widget.callBack();
    });
  }

  DateTime dateInternal;

  @override
  void initState() {
    super.initState();
    setState(() {
      dateInternal = widget._date;
    });
  }

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
        color: Colors.red,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: dateContainer(context),
        ),
      ),
    );
  }

  dateContainer(context) {
    return Container(
      child: FlatButton(
        child: Row(
          children: <Widget>[
            Text(
              widget._date.day.toString(),
              textScaleFactor: 2.6,
              style: TextStyle(color: Colors.white),
            ),
            Padding(padding: EdgeInsets.only(left: 12.0)),
            Column(
              children: <Widget>[
                Text(
                  month() + "  " + "${widget._date.year}",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  weekDay(),
                  style: TextStyle(color: Colors.white),
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
    if (widget._date.day.toString().length == 1)
      return "0${widget._date.day}";
    else
      return "${widget._date.day}";
  }

  month() {
    if (widget._date.month == 1)
      return "January";
    else if (widget._date.month == 2)
      return "February";
    else if (widget._date.month == 3)
      return "March";
    else if (widget._date.month == 4)
      return "April";
    else if (widget._date.month == 5)
      return "May";
    else if (widget._date.month == 6)
      return "June";
    else if (widget._date.month == 7)
      return "July";
    else if (widget._date.month == 8)
      return "August";
    else if (widget._date.month == 9)
      return "September";
    else if (widget._date.month == 10)
      return "October";
    else if (widget._date.month == 11)
      return "November";
    else
      return "December";
  }

  weekDay() {
    if (widget._date.weekday == 1)
      return "Monday";
    else if (widget._date.weekday == 2)
      return "Tuesday";
    else if (widget._date.weekday == 3)
      return "Wednesday";
    else if (widget._date.weekday == 4)
      return "Thursday";
    else if (widget._date.weekday == 5)
      return "Friday";
    else if (widget._date.weekday == 6)
      return "Saturday";
    else
      return "Sunday";
  }
}

class MonthWidgetContainer extends StatefulWidget {
  @override
  _MonthWidgetContainerState createState() => _MonthWidgetContainerState();
}

class _MonthWidgetContainerState extends State<MonthWidgetContainer> {
  DateTime _date = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showMonthPicker(
      context: context,
      initialDate: _date,
    );

    if (picked != null && picked != _date) {
      print('Date Selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }

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
      color: Colors.red,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: () {
                  _selectDate(context);
                }),
            dateContainer(context),
            IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                color: Colors.white,
                onPressed: () {
                  _selectDate(context);
                }),
          ],
        ),
      ),
    ));
  }

  dateContainer(context) {
    return Container(
      child: FlatButton(
        child: Row(
          children: <Widget>[
            Text(
              month() + "  " + "${_date.year}",
              textScaleFactor: 1.6,
              style: TextStyle(color: Colors.white),
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
}
