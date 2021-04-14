import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../Classes/DayData.dart';

class ColumnChart extends StatelessWidget {
  final List<DayData> week;
  final String index;

  ColumnChart({required this.week, required this.index});

  @override
  Widget build(BuildContext context) {
    final double w = 0.2;
    return Scaffold(
      body: Center(
        child: Container(
          child: SfCartesianChart(
            // Initialize category axis
            title: ChartTitle(text: 'week ' + index),
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(
              interval: 20,
              minimum: 0,
              maximum: 100,
            ),
            series: <ChartSeries>[
              // Initialize line series
              StackedColumnSeries<DayData, String>(
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  width: w,
                  color: Colors.red,
                  dataSource: week,
                  xValueMapper: (DayData calls, _) => calls.day,
                  yValueMapper: (DayData calls, _) => calls.closedCalls),

              StackedColumnSeries<DayData, String>(
                  width: w,
                  color: Colors.blue,
                  dataSource: week,
                  xValueMapper: (DayData calls, _) => calls.day,
                  yValueMapper: (DayData calls, _) => calls.notAnswered),
              StackedColumnSeries<DayData, String>(
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  width: w,
                  color: Colors.yellow,
                  dataSource: week,
                  xValueMapper: (DayData calls, _) => calls.day,
                  yValueMapper: (DayData calls, _) => calls.toRecall),
              StackedColumnSeries<DayData, String>(
                  width: w,
                  color: Colors.orange,
                  dataSource: week,
                  xValueMapper: (DayData calls, _) => calls.day,
                  yValueMapper: (DayData calls, _) => calls.recallMeeting),
              StackedColumnSeries<DayData, String>(
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  width: w,
                  color: Colors.green,
                  dataSource: week,
                  xValueMapper: (DayData calls, _) => calls.day,
                  yValueMapper: (DayData calls, _) => calls.meeting),
            ],
          ),
        ),
      ),
    );
  }
}
