import 'package:flutter/material.dart';
import 'daily.dart';
import 'monthly.dart';
import 'todo.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                text: "DAILY",
              ),
              Tab(
                text: "MONTHLY",
              ),
              Tab(
                text: "TODO",
              ),
            ],
          ),
          elevation: 4.0,
        ),
        body: TabBarView(
          children: <Widget>[
            Daily(),
            Monthly(),
            TodoWidget(),
            // yearly,
          ],
        ),
      ),
    );
  }
}
