import 'package:floor/floor.dart';

@Entity(tableName: 'Expense')
class Expense {
  @PrimaryKey(autoGenerate: true)
  int id;

  @ColumnInfo(name: 'name', nullable: false)
  String name;

  @ColumnInfo(name: 'cost', nullable: false)
  double cost;

  @ColumnInfo(name: 'day', nullable: false)
  int day;

  @ColumnInfo(name: 'month', nullable: false)
  int month;

  @ColumnInfo(name: 'year', nullable: false)
  int year;

  Expense(
    this.id,
    this.name,
    this.cost,
    this.day,
    this.month,
    this.year,
  );

  Expense.noId(
    this.name,
    this.cost,
    this.day,
    this.month,
    this.year,
  );

  @override
  String toString() {
    // TODO: implement toString
    return '{id: $id, name: $name, cost: $cost, day: $day,month: $month, year: $year}';
  }
}

@Entity(tableName: 'Saving')
class Saving {
  @PrimaryKey(autoGenerate: true)
  int id;

  @ColumnInfo(name: 'name', nullable: false)
  String name;

  @ColumnInfo(name: 'cost', nullable: false)
  double cost;

  @ColumnInfo(name: 'day', nullable: false)
  int day;

  @ColumnInfo(name: 'month', nullable: false)
  int month;

  @ColumnInfo(name: 'year', nullable: false)
  int year;

  Saving(
    this.id,
    this.name,
    this.cost,
    this.day,
    this.month,
    this.year,
  );

  Saving.noId(
    this.name,
    this.cost,
    this.day,
    this.month,
    this.year,
  );

  @override
  String toString() {
    // TODO: implement toString
    return '{id: $id, name: $name, cost: $cost, day: $day,month: $month, year: $year}';
  }
}
