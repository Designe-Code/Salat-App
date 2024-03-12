import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salati/helper/functions.dart';
import 'package:salati/models/prayer_data.dart';
import 'package:salati/services/prayer_service.dart';

class PrayerProvider extends ChangeNotifier {
  Timings? _timings;
  int _activePrayerIndex = 0;

  Timings? get timings => _timings;
  int get activePrayerIndex => _activePrayerIndex;

  void setTimings() {
    PrayerService.getPrayerTimings(city: 'Ouarzazate', country: 'Maroc')
      .then((timingsValue) {
        _timings = timingsValue;
        notifyListeners();
      });
  }

  void setActivePrayerIndex() {
    DateTime now = DateTime.now();
    String currentTime = DateFormat.jm().format(now);
    if (getTimeStamp(currentTime) > getTimeStamp(formatTime(_timings?.isha))) {
      _activePrayerIndex = 0;
    } else if (getTimeStamp(currentTime) > getTimeStamp(formatTime(timings?.maghrib))) {
      _activePrayerIndex = 5;
    } else if (getTimeStamp(currentTime) > getTimeStamp(formatTime(timings?.asr))) {
      _activePrayerIndex = 4;
    } else if (getTimeStamp(currentTime) > getTimeStamp(formatTime(timings?.dhuhr))) {
      _activePrayerIndex = 3;
    } else if (getTimeStamp(currentTime) > getTimeStamp(formatTime(timings?.sunrise))) {
      _activePrayerIndex = 2;
    } else if (getTimeStamp(currentTime) > getTimeStamp(formatTime(timings?.fajr))) {
      _activePrayerIndex = 1;
    }
  }
}