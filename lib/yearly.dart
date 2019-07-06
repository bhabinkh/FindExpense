import 'package:find_expense/month_picker.dart';
import 'package:flutter/material.dart';

var yearly = YearlyWidgetContainer();

class YearlyWidgetContainer extends StatefulWidget {
  @override
  _YearlyWidgetContainerState createState() => _YearlyWidgetContainerState();
}

class _YearlyWidgetContainerState extends State<YearlyWidgetContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          yearlyWidgetContainer(context),
        ],
      ),
    );
  }

  yearlyWidgetContainer(context) {
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
              child: Text("${_date.year}", textScaleFactor: 1.6),
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
    final DateTime picked = await showMonthPicker(
      context: context,
      initialDate: _date,
    );

    if (picked != null && picked != _date) {
      // print('Date Selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }
}
