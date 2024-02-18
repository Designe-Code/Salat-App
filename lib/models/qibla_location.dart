class QiblaLocation {
  int code;
  String status;
  Location data;

  QiblaLocation({
    required this.code,
    required this.status,
    required this.data,
  });

  factory QiblaLocation.fromJson(Map<String, dynamic> json) {
    return QiblaLocation(
      code: json['code'],
      status: json['status'],
      data: Location.fromJson(json['data']),
    );
  }
}

class Location {
  double latitude;
  double longitude;
  double direction;

  Location({
    required this.latitude,
    required this.longitude,
    required this.direction,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
      direction: json['direction'],
    );
  }
}
