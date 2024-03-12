import 'package:salati/helper/constant.dart';
import 'package:salati/helper/functions.dart';
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

  List<String?> _getListAdhanTimes(Timings? timings) {
    return [
      formatTime(timings?.fajr),
      formatTime(timings?.sunrise),
      formatTime(timings?.dhuhr),
      formatTime(timings?.asr),
      formatTime(timings?.maghrib),
      formatTime(timings?.isha)
    ];
  }

  void setPrayerTime(Timings? timings) {
    List<String?> listTimings = _getListAdhanTimes(timings);
    for (int i = 0; i < prayers.length; i++) {
      prayers[i].time = listTimings[i];
    }
  }

}