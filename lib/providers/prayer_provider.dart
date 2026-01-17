import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salati/helper/functions.dart';
import 'package:salati/models/prayer_data.dart';
import 'package:salati/services/prayer_service.dart';
import 'package:geolocator/geolocator.dart';

import 'package:geocoding/geocoding.dart';
import 'package:salati/helper/constant.dart';

class PrayerProvider extends ChangeNotifier {
  Timings? _timings;
  int _activePrayerIndex = 0;
  String _city = 'Current Location';

  Timings? get timings => _timings;
  int get activePrayerIndex => _activePrayerIndex;
  String get city => _city;

  Future<void> setTimings() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    // Force fresh location to avoid stale emulator data
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Fetch Prayer Times
    PrayerService.getPrayerTimingsByLocation(
            latitude: position.latitude, longitude: position.longitude)
        .then((timingsValue) {
      _timings = timingsValue;
      prayerController.setPrayerTime(_timings);
      setActivePrayerIndex();
      notifyListeners();
    }).catchError((e) {
      debugPrint("Error fetching prayer times: $e");
    });

    // Fetch City Name
    placemarkFromCoordinates(position.latitude, position.longitude)
        .then((placemarks) {
      if (placemarks.isNotEmpty) {
        String? locality = placemarks.first.locality;
        String? subAdmin = placemarks.first.subAdministrativeArea;

        if (locality != null && locality.isNotEmpty) {
          _city = locality;
        } else if (subAdmin != null && subAdmin.isNotEmpty) {
          _city = subAdmin;
        } else {
          _city = 'Current Location';
        }
        notifyListeners();
      }
    }).catchError((e) {
      debugPrint("Geocoding error: $e");
    });
  }

  void setActivePrayerIndex() {
    final now = DateTime.now();
    final currentTime = DateFormat.jm().format(now);
    final currentTimestamp = getTimeStamp(currentTime);

    int getPrayerTimestamp(String? time) => getTimeStamp(formatTime(time));

    switch (currentTimestamp) {
      case _ when currentTimestamp > getPrayerTimestamp(_timings?.isha):
        _activePrayerIndex = 0;
      case _ when currentTimestamp > getPrayerTimestamp(_timings?.maghrib):
        _activePrayerIndex = 5;
      case _ when currentTimestamp > getPrayerTimestamp(_timings?.asr):
        _activePrayerIndex = 4;
      case _ when currentTimestamp > getPrayerTimestamp(_timings?.dhuhr):
        _activePrayerIndex = 3;
      case _ when currentTimestamp > getPrayerTimestamp(_timings?.sunrise):
        _activePrayerIndex = 2;
      case _ when currentTimestamp > getPrayerTimestamp(_timings?.fajr):
        _activePrayerIndex = 1;
      default:
        _activePrayerIndex = 0;
    }
  }
}
