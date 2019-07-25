// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final database = _$AppDatabase();
    database.database = await database.open(name ?? ':memory:', _migrations);
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TodoDao _todoDaoInstance;

  ExpenseDao _expenseDaoInstance;

  SavingDao _savingDaoInstance;

  Future<sqflite.Database> open(String name, List<Migration> migrations) async {
    final path = join(await sqflite.getDatabasesPath(), name);

    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);
      },
      onCreate: (database, _) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Todo` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `description` TEXT NOT NULL, `date` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Expense` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `cost` REAL NOT NULL, `day` INTEGER NOT NULL, `month` INTEGER NOT NULL, `year` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Saving` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `cost` REAL NOT NULL, `day` INTEGER NOT NULL, `month` INTEGER NOT NULL, `year` INTEGER NOT NULL)');
      },
    );
  }

  @override
  TodoDao get todoDao {
    return _todoDaoInstance ??= _$TodoDao(database, changeListener);
  }

  @override
  ExpenseDao get expenseDao {
    return _expenseDaoInstance ??= _$ExpenseDao(database, changeListener);
  }

  @override
  SavingDao get savingDao {
    return _savingDaoInstance ??= _$SavingDao(database, changeListener);
  }
}

class _$TodoDao extends TodoDao {
  _$TodoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _todoInsertionAdapter = InsertionAdapter(
            database,
            'Todo',
            (Todo item) => <String, dynamic>{
                  'id': item.id,
                  'description': item.description,
                  'date': item.date
                }),
        _todoUpdateAdapter = UpdateAdapter(
            database,
            'Todo',
            'id',
            (Todo item) => <String, dynamic>{
                  'id': item.id,
                  'description': item.description,
                  'date': item.date
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final _todoMapper = (Map<String, dynamic> row) => Todo(
      row['id'] as int, row['description'] as String, row['date'] as String);

  final InsertionAdapter<Todo> _todoInsertionAdapter;

  final UpdateAdapter<Todo> _todoUpdateAdapter;

  @override
  Future<List<Todo>> findAllTodo() async {
    return _queryAdapter.queryList('SELECT * FROM Todo', mapper: _todoMapper);
  }

  @override
  Future<void> deleteTodo(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM Todo WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> insertTodo(Todo todo) async {
    await _todoInsertionAdapter.insert(todo, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await _todoUpdateAdapter.update(todo, sqflite.ConflictAlgorithm.abort);
  }
}

class _$ExpenseDao extends ExpenseDao {
  _$ExpenseDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _expenseInsertionAdapter = InsertionAdapter(
            database,
            'Expense',
            (Expense item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'cost': item.cost,
                  'day': item.day,
                  'month': item.month,
                  'year': item.year
                }),
        _expenseUpdateAdapter = UpdateAdapter(
            database,
            'Expense',
            'id',
            (Expense item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'cost': item.cost,
                  'day': item.day,
                  'month': item.month,
                  'year': item.year
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final _expenseMapper = (Map<String, dynamic> row) => Expense(
      row['id'] as int,
      row['name'] as String,
      row['cost'] as double,
      row['day'] as int,
      row['month'] as int,
      row['year'] as int);

  final InsertionAdapter<Expense> _expenseInsertionAdapter;

  final UpdateAdapter<Expense> _expenseUpdateAdapter;

  @override
  Future<List<Expense>> findExpenseOnDay(int day, int month, int year) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Expense where day = ? AND month = ? AND year = ?',
        arguments: <dynamic>[day, month, year],
        mapper: _expenseMapper);
  }

  @override
  Future<List<Expense>> findExpenseOnMonth(int month, int year) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Expense where month = ? AND year = ?',
        arguments: <dynamic>[month, year],
        mapper: _expenseMapper);
  }

  @override
  Future<void> deleteExpense(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM Expense WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> insertExpense(Expense expense) async {
    await _expenseInsertionAdapter.insert(
        expense, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> updateExpense(Expense expense) async {
    await _expenseUpdateAdapter.update(
        expense, sqflite.ConflictAlgorithm.abort);
  }
}

class _$SavingDao extends SavingDao {
  _$SavingDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _savingInsertionAdapter = InsertionAdapter(
            database,
            'Saving',
            (Saving item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'cost': item.cost,
                  'day': item.day,
                  'month': item.month,
                  'year': item.year
                }),
        _savingUpdateAdapter = UpdateAdapter(
            database,
            'Saving',
            'id',
            (Saving item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'cost': item.cost,
                  'day': item.day,
                  'month': item.month,
                  'year': item.year
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final _savingMapper = (Map<String, dynamic> row) => Saving(
      row['id'] as int,
      row['name'] as String,
      row['cost'] as double,
      row['day'] as int,
      row['month'] as int,
      row['year'] as int);

  final InsertionAdapter<Saving> _savingInsertionAdapter;

  final UpdateAdapter<Saving> _savingUpdateAdapter;

  @override
  Future<List<Saving>> findSavingOnDay(int day, int month, int year) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Saving where day = ? AND month = ? AND year = ?',
        arguments: <dynamic>[day, month, year],
        mapper: _savingMapper);
  }

  @override
  Future<List<Saving>> findSavingOnMonth(int month, int year) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Saving where month = ? AND year = ?',
        arguments: <dynamic>[month, year],
        mapper: _savingMapper);
  }

  @override
  Future<void> deleteSaving(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM Expense WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> insertSaving(Saving saving) async {
    await _savingInsertionAdapter.insert(
        saving, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> updateSaving(Saving saving) async {
    await _savingUpdateAdapter.update(saving, sqflite.ConflictAlgorithm.abort);
  }
}
