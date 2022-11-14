# How to load the appointment from JSON to the calendar with loadMoreWidgetBuilder?

This example demonstrates how to load the appointment from JSON to the calendar with loadMoreWidgetBuilder.

## Defining the calendar with load more widget builder

In the Flutter Calendar, the appointment can be shown from JSON and loaded to the calendar by using [loadMoreWidgetBuilder](https://pub.dev/documentation/syncfusion_flutter_calendar/latest/calendar/SfCalendar/loadMoreWidgetBuilder.html).


```

child: SfCalendar(
initialDisplayDate: DateTime(2017, 05, 01),
view: CalendarView.month,
allowedViews: [
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
)

Widget loadMoreWidget(
    BuildContext context, LoadMoreCallback loadMoreAppointments) {
  return FutureBuilder<void>(
    initialData: 'loading',
    future: loadMoreAppointments(),
    builder: (context, snapShot) {
      return Container(
          alignment: Alignment.center, child: CircularProgressIndicator());
    },
  );
}

```

## Handling appointments from JSON data

You can handle the appointment from the JSON data and load it to the Flutter calendar by using the [handleLoadMore](https://pub.dev/documentation/syncfusion_flutter_calendar/latest/calendar/CalendarDataSource/handleLoadMore.html) method.

```

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

```

You can also refer our UG documentation to know more about [LoadMore](https://help.syncfusion.com/flutter/calendar/load-more).

## Requirements to run the demo
* [VS Code](https://code.visualstudio.com/download)
* [Flutter SDK v1.22+](https://flutter.dev/docs/development/tools/sdk/overview)
* [For more development tools](https://flutter.dev/docs/development/tools/devtools/overview)

## How to run this application
To run this application, you need to first clone or download the ‘create a flutter maps widget in 10 minutes’ repository and open it in your preferred IDE. Then, build and run your project to view the output.

## Further help
For more help, check the [Syncfusion Flutter documentation](https://help.syncfusion.com/flutter/introduction/overview),
 [Flutter documentation](https://flutter.dev/docs/get-started/install).