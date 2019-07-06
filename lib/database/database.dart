import 'dart:async';
import 'package:find_expense/daos/expense_saving_dao.dart';
import 'package:find_expense/models/expense_saving.dart';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:find_expense/daos/TodoDao.dart';
import 'package:find_expense/models/todo.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Todo])
abstract class AppDatabase extends FloorDatabase {
  TodoDao get todoDao;
//  ExpenseDao get expenseDao;
//  SavingDao get savingDao;
}
