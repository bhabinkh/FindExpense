import 'package:find_expense/TodoItemWidget.dart';
import 'package:find_expense/daos/TodoDao.dart';
import 'package:find_expense/database/database.dart';
import 'package:find_expense/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

var todo = TodoWidget();

class TodoWidget extends StatefulWidget {
  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  bool _addTodo = false;
  bool _updateTodo = false;
  Todo _todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          FutureBuilder<List<Todo>>(
              future: Provider.of<AppDatabase>(context).todoDao.findAllTodo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TodoItemWidget(
                        callBack: updateTodo,
                        todo: Todo(
                            snapshot.data[index].id,
                            snapshot.data[index].description,
                            snapshot.data[index].date),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error Occured',
                          style: TextStyle(color: Colors.red)));
                } else {
                  return Center(
                      child: Container(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(),
                  ));
                }
              }),
          Positioned(
            bottom: 15,
            right: 15,
            child: Container(
              height: 48,
              width: 48,
              child: _addTodo
                  ? Container()
                  : FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _addTodo = true;
                        });
                      },
                      child: Icon(
                        Icons.add,
                        size: 36,
                      ),
                    ),
            ),
          ),
          _addTodo
              ? Positioned(
                  bottom: 10,
                  width: MediaQuery.of(context).size.width - 20,
                  child: Stack(
                    children: <Widget>[
                      Card(
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: _AddTodoForm(
                            callBack: closeAddTodo,
                            update: _updateTodo,
                            todo: _todo,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _addTodo = false;
                            });
                          },
                          icon: Icon(Icons.clear),
                        ),
                      )
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  void updateTodo(Todo todo, {deleteOrNotUpdate}) {
//    update logic
    print(todo);
    print(deleteOrNotUpdate);

    if (deleteOrNotUpdate) {
      // delete
      setState(() {
        Provider.of<AppDatabase>(context).todoDao.deleteTodo(todo.id);
      });
    } else {
      setState(() {
        _updateTodo = true;
        _addTodo = true;
        _todo = todo;
      });
    }
  }

  void closeAddTodo() {
    setState(() {
      _addTodo = false;
      _updateTodo = false;
    });
  }
}

class _AddTodoForm extends StatefulWidget {
  Function callBack;
  var update = false;
  Todo todo;

  _AddTodoForm({this.callBack, this.update, this.todo});

  @override
  __AddTodoFormState createState() => __AddTodoFormState();
}

class __AddTodoFormState extends State<_AddTodoForm> {
  final _formKey = GlobalKey<FormState>();

  final todoDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    todoDescriptionController.text =
        widget.update ? widget.todo.description : '';
  }

  @override
  void dispose() {
    super.dispose();
    todoDescriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextFormField(
                  controller: todoDescriptionController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                          color: Colors.black54,
                        )),
                    hintText: "Todo Description",
                  ),
                ),
              ),
              SizedBox(width: 8),
              Container(
                child: IconButton(
                  onPressed: () {
                    if (!widget.update) {
                      Todo todo = Todo.noId(
                        todoDescriptionController.text,
                        DateTime.now().toString(),
                      );
                      Provider.of<AppDatabase>(context)
                          .todoDao
                          .insertTodo(todo);
                    } else {
                      Provider.of<AppDatabase>(context).todoDao.updateTodo(Todo(
                            widget.todo.id,
                            todoDescriptionController.text,
                            DateTime.now().toString(),
                          ));
                    }
                    setState(() {
                      widget.callBack();
                    });
                  },
                  iconSize: 48,
                  icon: Icon(Icons.check_circle_outline, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
