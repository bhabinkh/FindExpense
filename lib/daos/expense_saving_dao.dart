import 'package:find_expense/models/expense_saving.dart';
import 'package:floor/floor.dart';

@dao
abstract class ExpenseDao {
  @Query(
      'SELECT * FROM Expense where day = :day AND month = :month AND year = :year')
  Future<List<Expense>> findExpenseOnDay(int day, int month, int year);

  @Query('SELECT * FROM Expense where month = :month AND year = :year')
  Future<List<Expense>> findExpenseOnMonth(int month, int year);

  @insert
  Future<void> insertExpense(Expense expense);

  @Query('DELETE FROM Expense WHERE id = :id')
  Future<void> deleteExpense(int id);

  @update
  Future<void> updateExpense(Expense expense);
}

@dao
abstract class SavingDao {
  @Query(
      'SELECT * FROM Saving where day = :day AND month = :month AND year = :year')
  Future<List<Saving>> findSavingOnDay(int day, int month, int year);

  @Query('SELECT * FROM Saving where month = :month AND year = :year')
  Future<List<Saving>> findSavingOnMonth(int month, int year);

  @insert
  Future<void> insertSaving(Saving saving);

  @Query('DELETE FROM Expense WHERE id = :id')
  Future<void> deleteSaving(int id);

  @update
  Future<void> updateSaving(Saving saving);
}
