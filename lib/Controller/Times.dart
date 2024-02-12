import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';

class TimeManager {
  static String getCurrentTime() {
    DateTime now = DateTime.now();
    return DateFormat.Hm().format(now);
  }

  static String getHijriTime() {
    HijriCalendar hijriCalendar = HijriCalendar.now();
    String dayName = DateFormat.EEEE().format(DateTime.now());
    return '$dayName ${hijriCalendar.hDay} ${hijriCalendar.getLongMonthName()} ${hijriCalendar.hYear}';
  }
}
