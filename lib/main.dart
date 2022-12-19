// ignore_for_file: void_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const LoadMoreWidget());

class LoadMoreWidget extends StatefulWidget {
  const LoadMoreWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ScheduleExample();
}

class ScheduleExample extends State<LoadMoreWidget> {
  final MeetingDataSource _events = MeetingDataSource(<_Meeting>[]);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SafeArea(
                    child: SfCalendar(
                  initialDisplayDate: DateTime(2017, 05, 01),
                  view: CalendarView.month,
                  allowedViews: const [
                    CalendarView.day,
                    CalendarView.week,
                    CalendarView.workWeek,
                    CalendarView.month,
                    CalendarView.timelineDay,
                    CalendarView.timelineWeek,
                    CalendarView.timelineWorkWeek,
                    CalendarView.timelineMonth,
                    CalendarView.schedule,
                  ],
                  dataSource: _events,
                  loadMoreWidgetBuilder: loadMoreWidget,
                )),
              )
            ],
          ),
        )));
  }

  Widget loadMoreWidget(
      BuildContext context, LoadMoreCallback loadMoreAppointments) {
    return FutureBuilder<void>(
      initialData: 'loading',
      future: loadMoreAppointments(),
      builder: (context, snapShot) {
        return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator());
      },
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(this.source);

  List<_Meeting> source;

  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].to;
  }

  @override
  bool isAllDay(int index) {
    return source[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return source[index].eventName;
  }

  @override
  Color getColor(int index) {
    return source[index].background;
  }

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    http.Response data = await http.get(Uri.parse(
        "https://js.syncfusion.com/demos/ejservices/api/Schedule/LoadData"));
    dynamic jsonData = json.decode(data.body);

    final List<_Meeting> appointmentData = [];
    for (dynamic data in jsonData) {
      _Meeting meetingData = _Meeting(
          data['Subject'],
          _convertDateFromString(
            data['StartTime'],
          ),
          _convertDateFromString(data['EndTime']),
          Colors.red,
          data['AllDay']);
      appointmentData.add(meetingData);
    }

    appointments.addAll(appointmentData);
    notifyListeners(CalendarDataSourceAction.add, appointmentData);
  }

  DateTime _convertDateFromString(String date) {
    return DateTime.parse(date);
  }
}

class _Meeting {
  _Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
