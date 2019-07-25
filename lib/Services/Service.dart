import 'package:find_expense/database/database.dart';
import 'package:find_expense/models/expense_saving.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Service {
  Future<double> dailySavingCalculate(DateTime date) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    double _totalSaving = 0;
    double _totalExpense = 0;

    await database.savingDao
        .findSavingOnDay(date.day, date.month, date.year)
        .then((List<Saving> savings) {
      savings.forEach((saving) => _totalSaving += saving.cost);
    });

    await database.expenseDao
        .findExpenseOnDay(date.day, date.month, date.year)
        .then((List<Expense> expenses) {
      expenses.forEach((expense) {
        _totalExpense += expense.cost;
      });
    });

    return (_totalSaving - _totalExpense);
  }

  int getLastDay(DateTime date) {
    var lastDayDateTime = (date.month < 12)
        ? new DateTime(date.year, date.month + 1, 0)
        : new DateTime(date.year + 1, 1, 0);

    return lastDayDateTime.day;
  }

  Future<DateTime> getPickedDate() async {
    print('Hello');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int day = prefs.getInt('day') ?? 0;
    int month = prefs.getInt('month') ?? 0;
    int year = prefs.getInt('year') ?? 0;

    print('Hello');
    print(DateTime(year, month, day).toString());

    return DateTime(year, month, day);
  }

  Future<void> savePickedDate(DateTime date) async {
    print('Hello1');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('day', date.day);
    prefs.setInt('month', date.month);
    prefs.setInt('year', date.year);

    print('Hello1 Over');
  }

  Future<List<BarChartData>> getMonthlyStatistics(int month, year) async {
    int N = getLastDay(DateTime(year, month));

    List<BarChartData> data = [];

    List<double> savings = [];

    for (int i = 0; i < N; i++) {
      data.add(BarChartData(
          i + 1, await dailySavingCalculate(DateTime(year, month, i))));
      savings.add((await dailySavingCalculate(DateTime(year, month, i))).abs());
    }

    savings.sort();

    var maxSaving = savings[savings.length - 1];

    data.forEach((data) {
      data.savingFraction = data.savingFraction / maxSaving;
    });

    return data;
  }
}

class BarChartData {
  int day;
  double savingFraction;

  BarChartData(this.day, this.savingFraction);

  @override
  String toString() {
    return '{"day" : $day, "fraction" : $savingFraction}';
  }
}
