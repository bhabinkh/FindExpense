import 'package:flutter/material.dart';
import 'daily.dart';
import 'monthly.dart';
import 'yearly.dart';
import 'todo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Find Expense"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                color: Colors.white,
                onPressed: null,
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                color: Colors.white,
                onPressed: null,
              )
            ],
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.create),
                ),
                Tab(
                  text: "DAILY",
                ),
                Tab(
                  text: "MONTHLY",
                ),
                Tab(
                  text: "YEARLY",
                ),
              ],
            ),
            elevation: 4.0,
          ),
          body: TabBarView(
            children: <Widget>[
              todo,
              daily,
              monthly,
              yearly,
            ],
          ),
        ),
      ),
    );
  }
}
