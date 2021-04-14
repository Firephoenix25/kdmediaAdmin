import 'package:flutter/material.dart';
import '../Widget/ColumnChart.dart';
import '../Classes/DayData.dart';
import '../Functions/CloudFirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProgress extends StatelessWidget {
  final Future future = getProgress();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            List list = createWeeks(snap.data);
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 500,
                    child: ColumnChart(
                      week: list[index],
                      index: (index + 1).toString(),
                    ),
                  );
                });
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}

List createWeeks(List<Map<String, dynamic>?> snap) {
  List<List<DayData>> list = [];
  List<DayData> slaveList = [];
  final List<String> weekdays = [
    "Lunedì",
    "Martedì",
    "Mercoledì",
    "Giovedì",
    "Venerdì",
    "Sabato",
    "Domenica",
  ];
  Map map = snap[0]!;
  DateTime? firstDay = DateTime.parse(map['time'].toDate().toString());

  Map map2 = snap[snap.length - 1]!;
  DateTime? lastDay = DateTime.parse(map2['time'].toDate().toString());

  int daysNumber = lastDay.difference(firstDay).inDays;

  int firstWeekLong = 8 - firstDay.weekday;
  double weeksNumber = (daysNumber - firstWeekLong) / 7;
  int lastWeekLong =
      (daysNumber - ((weeksNumber.toInt() * 7) + firstWeekLong)) + 1;

  print(firstWeekLong.toString());
  print(weeksNumber.toString());
  print(lastWeekLong.toString());
  print(lastDay.weekday);

  //AddFirstWeek

  if (firstWeekLong > 0) {
    for (int i = 1; i < 8; i++) {
      if (i < firstDay.weekday)
        slaveList.add(DayData(weekdays[i - 1], 0, 0, 0, 0, 0));
      else {
        if (snap
                .where((element) =>
                    DateTime.parse(element!['time'].toDate().toString()) ==
                    firstDay.add(Duration(days: (i - (7 - firstWeekLong)) - 1)))
                .toList()
                .length >
            0) {
          List mapInternal = snap
              .where((element) =>
                  DateTime.parse(element!['time'].toDate().toString()) ==
                  firstDay.add(Duration(days: (i - (7 - firstWeekLong)) - 1)))
              .toList();
          print(mapInternal[0]);
          slaveList.add(DayData(
              weekdays[i - 1],
              mapInternal[0]['ClosedCall'],
              mapInternal[0]['NotAnswered'],
              mapInternal[0]['ToRecall'],
              mapInternal[0]['RecallMeeting'],
              mapInternal[0]['Meeting']));
        } else
          slaveList.add(DayData(weekdays[i - 1], 0, 0, 0, 0, 0));
      }
    }
    list.add(slaveList);
  }

  //BodyWeek
  if (weeksNumber != 0) {
    for (int i2 = 0; i2 < weeksNumber; i2++) {
      slaveList = [];
      for (int i = 1; i < 8; i++) {
        int actualDay = firstWeekLong + i - 1 + (i2 * 7);
        print(firstDay.add(Duration(days: actualDay)).day);
        if (snap
                .where((element) =>
                    DateTime.parse(element!['time'].toDate().toString()) ==
                    firstDay.add(Duration(days: actualDay)))
                .toList()
                .length >
            0) {
          List mapInternal = snap
              .where((element) =>
                  DateTime.parse(element!['time'].toDate().toString()) ==
                  firstDay.add(Duration(days: actualDay)))
              .toList();
          slaveList.add(DayData(
              weekdays[i - 1],
              mapInternal[0]['ClosedCall'],
              mapInternal[0]['NotAnswered'],
              mapInternal[0]['ToRecall'],
              mapInternal[0]['RecallMeeting'],
              mapInternal[0]['Meeting']));
        } else
          slaveList.add(DayData(weekdays[i - 1], 0, 0, 0, 0, 0));
      }
      list.add(slaveList);
    }
  }
  //LastWeek
  print("---");
  if (lastWeekLong > 0) {
    slaveList = [];
    for (int i = 1; i < 8; i++) {
      print(i - 1 < lastDay.weekday);
      if (i - 1 < lastDay.weekday == false)
        slaveList.add(DayData(weekdays[i - 1], 0, 0, 0, 0, 0));
      else {
        int day = (lastDay.weekday - lastWeekLong) + i - 1;
        print(lastDay.subtract(Duration(days: day)).day);
        if (snap
                .where((element) =>
                    DateTime.parse(element!['time'].toDate().toString()) ==
                    lastDay.subtract(Duration(days: day)))
                .toList()
                .length >
            0) {
          List mapInternal = snap
              .where((element) =>
                  DateTime.parse(element!['time'].toDate().toString()) ==
                  lastDay.subtract(Duration(days: day)))
              .toList();
          slaveList.add(DayData(
              weekdays[i - 1],
              mapInternal[0]['ClosedCall'],
              mapInternal[0]['NotAnswered'],
              mapInternal[0]['ToRecall'],
              mapInternal[0]['RecallMeeting'],
              mapInternal[0]['Meeting']));
        } else
          slaveList.add(DayData(weekdays[i - 1], 0, 0, 0, 0, 0));
      }
    }
    list.add(slaveList);
  }

  return list;
}
