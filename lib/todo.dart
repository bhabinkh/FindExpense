import 'package:flutter/material.dart';
import 'date.dart';

var todo = Todo();

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          dateWidgetContainer,
        ],
      ),
    );
  }
}
