import 'dart:convert';

import 'package:salati/helper/constant.dart';
import 'package:salati/models/prayer.dart';
import 'package:salati/models/prayer_data.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class PrayerController {
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
      adan: 'Sunrize',
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

  String _formatTime(time) {
    bool isStandardFormat = time.contains("AM") || time.contains("PM");

    if (isStandardFormat) {
      return time;
    } else {
      DateTime dateTime = DateFormat.Hm().parse(time);
      String formattedTime = DateFormat.jm().format(dateTime);
      return formattedTime;
    }
  }

  int _getTimeStamp(time) {
    DateTime dateTime = DateFormat.jm().parse(time);
    int timestamp = dateTime.millisecondsSinceEpoch;
    return timestamp;
  }

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    String formattedDate = dateFormat.format(now);
    return formattedDate;
  }

  int getActiveIndex(Timings? timings) {
    DateTime now = DateTime.now();
    String currentTime = DateFormat.jm().format(now);
    if (_getTimeStamp(currentTime) < _getTimeStamp( _formatTime(timings?.sunrise))) return 0;
    if (_getTimeStamp(currentTime) < _getTimeStamp( _formatTime(timings?.dhuhr))) return 1;
    if (_getTimeStamp(currentTime) < _getTimeStamp( _formatTime(timings?.asr))) return 2;
    if (_getTimeStamp(currentTime) < _getTimeStamp( _formatTime(timings?.maghrib))) return 3;
    if (_getTimeStamp(currentTime) < _getTimeStamp( _formatTime(timings?.isha))) return 4;
    return 5;
  }

  void setPrayerTime(fajr, sunrise, duhr, asr, maghrib, ishaa) {
    prayers[0].time = _formatTime(fajr);
    prayers[1].time = _formatTime(sunrise);
    prayers[2].time = _formatTime(duhr);
    prayers[3].time = _formatTime(asr);
    prayers[4].time = _formatTime(maghrib);
    prayers[5].time = _formatTime(ishaa);
  }

  Future<Timings> getPrierTimings() async {
    final response = await http.get(Uri.parse('http://api.aladhan.com/v1/timingsByCity/${_getCurrentDate()}?city=Ouarzazate&country=Maroc&method=8'));

    if (response.statusCode == 200) {
      return PrayerData.fromJson(jsonDecode(response.body) as Map<String, dynamic>).data.timings;
    } else {
      throw Exception('Failed to load Pryer timings');
    }
  }

}