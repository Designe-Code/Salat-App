import 'package:geolocator/geolocator.dart';
import 'package:salati/models/qibla_location.dart';
import 'package:salati/services/qibla_service.dart';

class QiblaController {
  final QiblaService _service = QiblaService();

  Position? currentPosition;
  double? qiblaDirection;

  Future<void> _requestLocationPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
  }

  Future<Location> _getQiblaLocation(Position devicePosition) async {
    return await _service.getQiblaLocation(devicePosition);
  }

  Future<Position?> getCurrentLocation() async {
    await _requestLocationPermissions();
    currentPosition = await Geolocator.getCurrentPosition();
    return currentPosition;
  }

  Future<Location?> getQiblaDirection() async {
    Position? currentPosition = await getCurrentLocation();

    if (currentPosition != null) {
      return await _getQiblaLocation(currentPosition);
    } else {
      return null;
    }
  }
}
