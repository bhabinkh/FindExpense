import 'package:find_expense/home.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'database/database.dart';

Future<void> main() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  runApp(
    MyApp(
      appDatabase: database,
    ),
  );
}

class MyApp extends StatelessWidget {
  AppDatabase appDatabase;

  MyApp({@required this.appDatabase});

  @override
  Widget build(BuildContext context) {
    return Provider<AppDatabase>.value(
      value: appDatabase,
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.red,
            textTheme: TextTheme(title: TextStyle(color: Colors.white))),
        home: HomePage(),
      ),
    );
  }
}
