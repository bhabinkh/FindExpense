import 'package:find_expense/models/todo.dart';
import 'package:floor/floor.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM Todo')
  Future<List<Todo>> findAllTodo();

  @insert
  Future<void> insertTodo(Todo todo);

  @Query('DELETE FROM Todo WHERE id = :id')
  Future<void> deleteTodo(int id);

  @update
  Future<void> updateTodo(Todo todo);
}
