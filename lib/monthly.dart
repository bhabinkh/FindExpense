import 'package:flutter/material.dart';
import 'date.dart';

var monthly = Monthly();

class Monthly extends StatefulWidget {
  @override
  _MonthlyState createState() => _MonthlyState();
}

class _MonthlyState extends State<Monthly> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          monthWidgetContainer,
        ],
      ),
    );
  }
}
