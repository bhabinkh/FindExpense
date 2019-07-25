import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Services/Service.dart';
import 'database/database.dart';
import 'date.dart';
import 'models/expense_saving.dart';

import 'package:shared_preferences/shared_preferences.dart';

var daily = Daily();

class Daily extends StatefulWidget {
  @override
  _DailyState createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  bool _add = false;
  DateTime pickedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Function updateOnDateSelectFunction = () {
      setState(() {});
    };

    return FutureBuilder(
      future: Service().getPickedDate(),
      builder: (BuildContext context, AsyncSnapshot<DateTime> snapshot) {
        DateTime _date = DateTime.now();
        if (snapshot.hasData) {
          _date = snapshot.data;
        }

        Function callBack = (bool expenseForm, var data) {
          if (expenseForm) {
            Provider.of<AppDatabase>(context).expenseDao.insertExpense(
                  Expense.noId(
                    data['text'],
                    data['price'],
                    _date.day,
                    _date.month,
                    _date.year,
                  ),
                );
          } else {
            Provider.of<AppDatabase>(context).savingDao.insertSaving(
                  Saving.noId(
                    data['text'],
                    data['price'],
                    _date.day,
                    _date.month,
                    _date.year,
                  ),
                );
          }
          setState(() {
            this._add = false;
          });
        };

        return Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                DateWidgetContainer(updateOnDateSelectFunction, _date),
                FutureBuilder(
                    future: Provider.of<AppDatabase>(context)
                        .savingDao
                        .findSavingOnDay(_date.day, _date.month, _date.year),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        double _totalSaving = 0;
                        for (var expense in snapshot.data) {
                          _totalSaving += expense.cost;
                        }

                        return _ListItemWidget(
                          hint: 'Saving',
                          list: snapshot.data,
                          totalExpense: _totalSaving,
                        );
                      }
                      return Container(
                          height: 200,
                          child: Center(child: CircularProgressIndicator()));
                    }),
                SizedBox(height: 4),
                FutureBuilder(
                    future: Provider.of<AppDatabase>(context)
                        .expenseDao
                        .findExpenseOnDay(_date.day, _date.month, _date.year),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        double _totalExpense = 0;
                        for (var expense in snapshot.data) {
                          _totalExpense += expense.cost;
                        }

                        return _ListItemWidget(
                          hint: 'Expense',
                          list: snapshot.data,
                          totalExpense: _totalExpense,
                        );
                      }
                      return Container(
                          height: 200,
                          child: Center(child: CircularProgressIndicator()));
                    }),
              ],
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text('Savings', style: TextStyle(color: Colors.white)),
                  FutureBuilder(
                    future: Service().dailySavingCalculate(_date),
                    builder:
                        (BuildContext context, AsyncSnapshot<double> snapshot) {
                      double _savings = 0;
                      if (snapshot.hasData) {
                        _savings = snapshot.data;
                      }
                      return Text(
                          _savings > 0
                              ? '+' + _savings.toString()
                              : _savings.toString(),
                          style: TextStyle(color: Colors.white));
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 15,
              right: 15,
              child: Container(
                height: 48,
                width: 48,
                child: _add
                    ? Container()
                    : FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _add = true;
                          });
                        },
                        child: Icon(Icons.add, size: 36),
                      ),
              ),
            ),
            _add
                ? Positioned(
                    bottom: 4,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Card(
                          elevation: 6,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 8),
                            child: _AddForm(callBackOnAdd: callBack),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _add = false;
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
        );
      },
    );
  }
}

class _AddForm extends StatefulWidget {
  Function callBackOnAdd;

  _AddForm({@required this.callBackOnAdd});

  @override
  __AddFormState createState() => __AddFormState();
}

class __AddFormState extends State<_AddForm> {
  final _formKey = GlobalKey<FormState>();

  final textController = TextEditingController();
  final priceController = TextEditingController();

  bool _expenseForm = true;

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
    priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FlatButton(
                color: Colors.red,
                child: Text(_expenseForm ? 'Expense' : 'Saving',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    _expenseForm = !_expenseForm;
                  });
                },
              ),
              SizedBox(width: 4),
              Text('Tap to change')
            ],
          ),
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.fastfood, size: 32),
                color: Colors.red,
              ),
              Flexible(
                flex: 5,
                child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    hintText: "Todo Description",
                  ),
                ),
              ),
              SizedBox(width: 8),
              Flexible(
                flex: 3,
                child: TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    hintText: "Price",
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.callBackOnAdd(_expenseForm, {
                    'text': textController.text,
                    'price': double.parse(priceController.text),
                  });
                },
                icon: Icon(Icons.check_circle_outline, size: 32),
                color: Colors.red,
              )
            ],
          )
        ],
      ),
    );
  }
}

class _ListItemWidget extends StatefulWidget {
  List<dynamic> list;
  String hint;
  double totalExpense;

  _ListItemWidget({this.hint, this.list, this.totalExpense});

  @override
  __ListItemWidgetState createState() => __ListItemWidgetState();
}

class __ListItemWidgetState extends State<_ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: widget.list.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Container(
            color: Colors.black12,
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text('Total ${widget.hint}'),
                Text(widget.totalExpense.toString())
              ],
            ),
          );
        }
        return InkWell(
          onLongPress: () {},
          child: _ItemWidget(
            name: widget.list[index - 1].name,
            price: (widget.list[index - 1].cost),
            icon: Icons.near_me,
          ),
        );
      },
    );
  }
}

class _ItemWidget extends StatelessWidget {
  String name;
  double price;
  IconData icon;

  _ItemWidget({@required this.name, @required this.price, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black26, width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            getInitial(),
            Text(price.toString()),
          ],
        ),
      ),
    );
  }

  Widget getInitial() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        (icon != null) ? Icon(icon, size: 16) : SizedBox(width: 16),
        Text(name)
      ],
    );
  }
}
