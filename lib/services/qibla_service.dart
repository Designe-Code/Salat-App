import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/models/qibla_location.dart';
import 'package:http/http.dart' as http;

class QiblaService {
  final GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;

  Future<Location> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      throw const PermissionDeniedException('Location permission denied');
    } else {
      Position position = await _geolocator.getCurrentPosition();
      Location qiblaLocation = await getQiblaLocation(position);

      return qiblaLocation;
    }
  }

  Future<Location> getQiblaLocation(Position devicePosition) async {
    String apiUrl = '$qiblaApiUrl/${devicePosition.latitude}/${devicePosition.longitude}';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return QiblaLocation.fromJson(jsonDecode(response.body) as Map<String, dynamic>).data;
    } else {
      throw Exception('Failed to load Qibla location');
    }
  }
}
