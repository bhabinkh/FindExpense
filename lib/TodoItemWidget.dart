import 'package:flutter/material.dart';

import 'models/todo.dart';

class TodoItemWidget extends StatefulWidget {
  Todo todo;
  Function callBack;

  TodoItemWidget({this.todo, this.callBack});

  @override
  _TodoItemWidgetState createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.todo.description,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.todo.date,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                widget.callBack(widget.todo, deleteOrNotUpdate: false);
              },
              icon: Icon(Icons.edit, size: 24, color: Colors.black),
            ),
            SizedBox(width: 10),
            IconButton(
              onPressed: () {
                widget.callBack(widget.todo, deleteOrNotUpdate: true);
              },
              icon: Icon(Icons.delete, size: 24, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
