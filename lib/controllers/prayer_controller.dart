import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:salati/helper/constant.dart';
import 'package:salati/models/prayer.dart';
import 'package:salati/models/prayer_data.dart';


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

  Map<String, String> getNextPrayer(int activeIndex, Timings timings) {
    if (activeIndex == 0) {
      return {
        'name' : 'Fajr',
        'time' : timings.fajr
      };
    }
     if (activeIndex == 1) {
      return {
        'name' : 'Sunrise',
        'time' : timings.sunrise
      };
    }
    if (activeIndex == 2) {
      return {
        'name' : 'Dhuhr',
        'time' : timings.dhuhr
      };
    }
    if (activeIndex == 3) {
      return {
        'name' : 'Asr',
        'time' : timings.asr
      };
    }
    if (activeIndex == 4) {
      return {
        'name' : 'Maghrib',
        'time' : timings.maghrib
      };
    }
   return {
     'name' : 'Ishaa',
        'time' : timings.isha
   };


  }

  int getActiveIndex(Timings? timings) {
    DateTime now = DateTime.now();
    String currentTime = DateFormat.jm().format(now);
    if (_getTimeStamp(currentTime) > _getTimeStamp( _formatTime(timings?.isha))) return 0;
    if (_getTimeStamp(currentTime) > _getTimeStamp( _formatTime(timings?.maghrib))) return 5;
    if (_getTimeStamp(currentTime) > _getTimeStamp( _formatTime(timings?.asr))) return 4;
    if (_getTimeStamp(currentTime) > _getTimeStamp( _formatTime(timings?.dhuhr))) return 3;
    if (_getTimeStamp(currentTime) > _getTimeStamp( _formatTime(timings?.sunrise))) return 2;
    return 1;
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