import 'package:floor/floor.dart';

@Entity(tableName: 'Todo')
class Todo {
  @PrimaryKey(autoGenerate: true)
  int id;

  @ColumnInfo(name: 'description', nullable: false)
  String description;

  @ColumnInfo(name: 'date', nullable: false)
  String date;

  Todo(this.id, this.description, this.date);

  Todo.noId(this.description, this.date);

  @override
  String toString() {
    return '{id: $id, todo: $description, date: $date}';
  }
}
