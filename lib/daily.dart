import 'package:flutter/material.dart';
import 'date.dart';

var daily = Daily();

class Daily extends StatefulWidget {
  @override
  _DailyState createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          DateWidgetContainer(),
        ],
      ),
    );
  }
}
