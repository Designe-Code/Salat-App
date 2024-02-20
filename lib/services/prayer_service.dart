import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/models/prayer_data.dart';

class PrayerService {
  static String _getCurrentDate() {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    String formattedDate = dateFormat.format(now);
    return formattedDate;
  }

  static Future<Timings> getPrayerTimings({required String city, required String country}) async {
    final response = await http.get(Uri.parse('$prayerByCityApiUrl/${_getCurrentDate()}?city=$city&country=$country&method=8'));

    if (response.statusCode == 200) {
      return PrayerData.fromJson(jsonDecode(response.body) as Map<String, dynamic>).data.timings;
    } else {
      throw Exception('Failed to load Pryer timings');
    }
  }
}