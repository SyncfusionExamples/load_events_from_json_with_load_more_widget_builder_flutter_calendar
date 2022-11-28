# How to load the appointment from JSON to the calendar with loadMoreWidgetBuilder?

This example demonstrates how to load the appointment from JSON to the calendar with loadMoreWidgetBuilder.

## Defining the calendar with load more widget builder

In the Flutter Calendar, the appointment can be shown from JSON and loaded to the calendar by using [loadMoreWidgetBuilder](https://pub.dev/documentation/syncfusion_flutter_calendar/latest/calendar/SfCalendar/loadMoreWidgetBuilder.html).

By using the loadMoreWidgetBuilder, you can create a custom widget that will be displayed as a loading indicator in the calendar whenever the calendar view changes and when the calendar schedule view reaches the start or end position to load more appointments.

## Handling appointments from JSON data

In this sample we have handled the appointment's from the JSON data and load it to the Flutter calendar by using the [handleLoadMore](https://pub.dev/documentation/syncfusion_flutter_calendar/latest/calendar/CalendarDataSource/handleLoadMore.html) method.

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