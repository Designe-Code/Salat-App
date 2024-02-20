import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/helper/functions.dart';
import 'package:salati/models/prayer.dart';
import 'package:salati/models/prayer_data.dart';
import 'package:salati/services/shared_preferences_service.dart';

class PrayerProvider extends ChangeNotifier {
  Timings? _timings;

  final List<Prayer> prayers = [
    Prayer(
      index: 0,
      icon: smallFajr,
      adan: 'Fajr',
      time: '',
      bell: activeBell
    ),
    Prayer(
      index: 1,
      icon: smallSunrise,
      adan: 'Sunrise',
      time: '',
      bell: activeBell
    ),
    Prayer(
      index: 2,
      icon: smallDuhr,
      adan: 'Duhr',
      time: '',
      bell: activeBell
    ),
    Prayer(
      index: 3,
      icon: smallAsr,
      adan: 'Assr',
      time: '',
      bell: inactiveBell
    ),
    Prayer(
      index: 4,
      icon: smallMaghrib,
      adan: 'Maghrib',
      time: '',
      bell: activeBell
    ),
    Prayer(
      index: 5,
      icon: smallIshaa,
      adan: 'Ishaa',
      time: '',
      bell: activeBell
    ),
  ];

  Timings? get timings => _timings;

  void setTimings() {
    SharedPreferencesService.getStringData('timings')
      .then((timingsValue) => {
        _timings = Timings.fromJson(jsonDecode(timingsValue))
      });
    notifyListeners();
  }

  List<String?> getListAdhanTimes() {
    return [
      formatTime(_timings?.fajr),
      formatTime(_timings?.sunrise),
      formatTime(_timings?.dhuhr),
      formatTime(_timings?.asr),
      formatTime(_timings?.maghrib),
      formatTime(_timings?.isha)
    ];
  }

  Map<String, dynamic> getNextAdhan() {
    DateTime now = DateTime.now();
    String currentTime = DateFormat.jm().format(now);
    if (getTimeStamp(currentTime) > getTimeStamp(formatTime(_timings?.isha))) {
      return {
        'index': 0,
        'name': 'Fajr',
        'time': _timings?.fajr ?? '',
      };
    } else if (getTimeStamp(currentTime) > getTimeStamp(formatTime(timings?.maghrib))) {
      return {
        'index': 5,
        'name': 'Ishaa',
        'time': _timings?.isha ?? '',
      };
    } else if (getTimeStamp(currentTime) > getTimeStamp(formatTime(timings?.asr))) {
      return {
        'index': 4,
        'name': 'Maghrib',
        'time': _timings?.maghrib ?? '',
      };
    } else if (getTimeStamp(currentTime) > getTimeStamp(formatTime(timings?.dhuhr))) {
      return {
        'index': 3,
        'name': 'Assr',
        'time': _timings?.asr ?? '',
      };
    } else if (getTimeStamp(currentTime) > getTimeStamp(formatTime(timings?.sunrise))) {
      return {
        'index': 2,
        'name': 'Duhr',
        'time': _timings?.dhuhr ?? '',
      };
    } else if (getTimeStamp(currentTime) > getTimeStamp(formatTime(timings?.fajr))) {
      return {
        'index': 1,
        'name': 'Sunrise',
        'time': _timings?.sunrise ?? '',
      };
    }
    return {
        'index': 0,
        'name': 'Fajr',
        'time': _timings?.fajr ?? '',
      };
  }

}