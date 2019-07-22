import 'package:flutter/material.dart';
import 'date.dart';

var daily = Daily();

class Daily extends StatefulWidget {
  @override
  _DailyState createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  bool _add = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            DateWidgetContainer(),
            _ListItemWidget(hint: 'Saving'),
            SizedBox(height: 4),
            _ListItemWidget(hint: 'Expense'),
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
              Text('+' + 2000.toString(),
                  style: TextStyle(color: Colors.white)),
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
                        child: _AddForm(),
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
  }
}

class _AddForm extends StatefulWidget {
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
                onPressed: () {},
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

class _ListItemWidget extends StatelessWidget {
  List<dynamic> list;
  String hint;

  _ListItemWidget({this.hint, this.list});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: 10 + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Container(
            color: Colors.black12,
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[Text('Total $hint'), Text(40000.toString())],
            ),
          );
        }
        return InkWell(
          onLongPress: () {},
          child: _ItemWidget(
            name: 'Food',
            price: 2000,
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
