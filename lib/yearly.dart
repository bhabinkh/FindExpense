import 'package:flutter/material.dart';
import 'date.dart';

var yearly = Yearly();

class Yearly extends StatefulWidget {
  @override
  _YearlyState createState() => _YearlyState();
}

class _YearlyState extends State<Yearly> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          yearWidgetContainer,
        ],
      ),
    );
  }
}
