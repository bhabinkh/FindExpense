import 'package:flutter/material.dart';
import 'Services/Service.dart';
import 'date.dart';

var monthly = Monthly();

class Monthly extends StatefulWidget {
  @override
  _MonthlyState createState() => _MonthlyState();
}

class _MonthlyState extends State<Monthly> {
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

          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DateWidgetContainer(updateOnDateSelectFunction, _date),
                _TEMP(_date)
              ],
            ),
          );
        });
  }
}

class _TEMP extends StatelessWidget {
  DateTime date;

  _TEMP(this.date);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Service().getMonthlyStatistics(date.month, date.year),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData)
          return Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.25), width: 2),
                    top: BorderSide(
                        color: Colors.grey.withOpacity(0.25), width: 2))),
            child: BarChart(snapshot.data),
          );

        return CircularProgressIndicator();
      },
    );
  }
}

class BarChart extends StatefulWidget {
  List<BarChartData> data;

  BarChart(this.data);

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  bool pressed = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 300,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 10);
          },
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onDoubleTap: () {
                      setState(() {
                        pressed = true;
                      });
                    },
                    child: CustomPaint(
                      painter: BarChartItemPainter(
                          fraction: widget.data[index].savingFraction),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                    child: Center(
                        child: Text('$index',
                            style: TextStyle(
                                color: pressed ? Colors.red : Colors.green))),
                    width: 16)
              ],
            );
          },
        ),
      ),
    );
  }
}

class BarChartItemPainter extends CustomPainter {
  Paint _paint;

  double fraction;

  BarChartItemPainter({this.fraction}) {
    _paint = Paint()
      ..color = Colors.red.withOpacity(0.75)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    fraction = fraction * size.height * 0.5;

    if (fraction > 0) {
      canvas.drawLine(
          Offset(0, size.height * 0.5),
          Offset(0, size.height * 0.5 - fraction),
          _paint..color = Colors.green);
    } else if (fraction < 0) {
      print(fraction);

      canvas.drawLine(Offset(0, size.height * 0.5),
          Offset(0, size.height * 0.5 - fraction), _paint);
    } else {
      canvas.drawLine(Offset(0, size.height * 0.5),
          Offset(0, size.height * 0.5 - fraction), _paint..color = Colors.grey);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
