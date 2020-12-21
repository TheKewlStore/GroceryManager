import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat dateTimeFormat = DateFormat("yyyy-MM-dd HH:mm");
DateFormat dateFormat = DateFormat("yyyy-MM-dd");
DateFormat timeFormat = DateFormat("HH:mm");
DateFormat dateTimeDaysFormat = DateFormat("E, MMM dd, HH:mm");

String formatDateTime(DateTime dateTime) {
  return dateTimeFormat.format(dateTime);
}

String formatDateTimeDays(DateTime dateTime) {
  return dateTimeDaysFormat.format(dateTime);
}

String formatDate(DateTime dateTime) {
  return dateFormat.format(dateTime);
}

String formatTime(DateTime dateTime) {
  return timeFormat.format(dateTime);
}

DateTime parseDateTime(String dateTimeInput) {
  return dateTimeFormat.parse(dateTimeInput);
}

DateTime parseDate(String dateInput) {
  return dateFormat.parse(dateInput);
}

DateTime parseTime(String timeInput) {
  return timeFormat.parse(timeInput);
}

Future<TimeOfDay> show24HourTimePicker(
    BuildContext context, TimeOfDay initialTime) async {
  return showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (BuildContext context, Widget child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child,
      );
    },
  );
}

Widget dateTimePicker(BuildContext context, Function(String) saveValueFunction,
    DateTime initialValue,
    {bool enabled = true}) {
  if (enabled) {
    return FormField(
        builder: (FormFieldState<String> state) {
          return RaisedButton(
            child: Text(state.value),
            onPressed: () {
              DateTime currentDateTime = parseDateTime(state.value);

              showDatePicker(
                context: context,
                initialDate: parseDate(state.value),
                firstDate: DateTime(currentDateTime.year - 1),
                lastDate: DateTime(currentDateTime.year + 1),
              ).then((date) {
                if (date == null) {
                  return;
                }
                show24HourTimePicker(
                        context, TimeOfDay.fromDateTime(currentDateTime))
                    .then((time) {
                  if (date == null) {
                    return;
                  }

                  state.didChange(formatDateTime(DateTime(date.year, date.month,
                      date.day, time.hour, time.minute)));
                  state.save();
                });
              });
            },
          );
        },
        onSaved: saveValueFunction,
        initialValue: formatDateTime(initialValue));
  } else {
    return FormField(
        builder: (FormFieldState<String> state) {
          return RaisedButton(
            child: Text(state.value),
            onPressed: null,
          );
        },
        onSaved: saveValueFunction,
        initialValue: formatDateTime(initialValue));
  }
}

Widget timePicker(BuildContext context, Function(String) saveValueFunction,
    DateTime initialValue,
    {bool enabled = true}) {
  if (enabled) {
    return FormField(
        builder: (FormFieldState<String> state) {
          return RaisedButton(
            child: Text(state.value),
            onPressed: () {
              DateTime currentDateTime = parseTime(state.value);
              show24HourTimePicker(
                      context, TimeOfDay.fromDateTime(currentDateTime))
                  .then((date) {
                if (date == null) {
                  return;
                }

                state.didChange(formatTime(DateTime(
                    initialValue.year,
                    initialValue.month,
                    initialValue.day,
                    date.hour,
                    date.minute)));
                state.save();
              });
            },
          );
        },
        onSaved: saveValueFunction,
        initialValue: formatTime(initialValue));
  } else {
    return FormField(
        builder: (FormFieldState<String> state) {
          return RaisedButton(
            child: Text(state.value),
            onPressed: null,
          );
        },
        onSaved: saveValueFunction,
        initialValue: formatTime(initialValue));
  }
}

Widget datePicker(BuildContext context, Function(String) saveValueFunction,
    DateTime initialValue,
    {Key key}) {
  return FormField(
      builder: (FormFieldState<String> state) {
        return RaisedButton(
            child: Text(state.value),
            onPressed: () {
              DateTime currentDate = parseDate(state.value);
              showDatePicker(
                context: context,
                initialDate: parseDate(state.value),
                firstDate: DateTime(currentDate.year - 1),
                lastDate: DateTime(currentDate.year + 1),
              ).then((date) {
                if (date == null) {
                  return;
                }

                state.didChange(formatDate(date));
              });
            });
      },
      key: key,
      onSaved: saveValueFunction,
      initialValue: formatDate(initialValue));
}

DateTime getToday() {
  // Return current date at 00:00.
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day, 0, 0);
}

DateTime dayOf(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0);
}

DateTime dateWithTime(DateTime date, DateTime time) {
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}
