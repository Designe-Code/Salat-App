import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';

String formatTime(time) {
  if (time != null) {
    bool isStandardFormat = time.contains("AM") || time.contains("PM");

    if (isStandardFormat) {
      return time;
    } else {
      DateTime dateTime = DateFormat.Hm().parse(time);
      String formattedTime = DateFormat.jm().format(dateTime);
      return formattedTime;
    }
  }
  return '';
}

int getTimeStamp(time) {
  DateTime dateTime = DateFormat.jm().parse(time);
  int timestamp = dateTime.millisecondsSinceEpoch;
  return timestamp;
}

String getCurrentTime() {
  DateTime now = DateTime.now();
  return DateFormat.Hm().format(now);
}

String getHijriTime() {
  HijriCalendar hijriCalendar = HijriCalendar.now();
  String dayName = DateFormat.EEEE().format(DateTime.now());
  return '$dayName ${hijriCalendar.hDay} ${hijriCalendar.getLongMonthName()} ${hijriCalendar.hYear}';
}

void navigateTo(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen)
  );
}

void goBack(BuildContext context) {
  Navigator.pop(context);
}