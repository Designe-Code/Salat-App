class Mosque {
  final String name;
  final double latitude;
  final double longitude;
  final double? distance; // Distance in meters from user location
  final String? address;

  Mosque({
    required this.name,
    required this.latitude,
    required this.longitude,
    this.distance,
    this.address,
  });

  factory Mosque.fromJson(Map<String, dynamic> json) {
    return Mosque(
      name: json['tags']?['name'] ?? 'Unnamed Mosque',
      latitude: json['lat']?.toDouble() ?? 0.0,
      longitude: json['lon']?.toDouble() ?? 0.0,
      address: json['tags']?['addr:full'] ?? 
               json['tags']?['addr:street'] ?? 
               json['tags']?['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'distance': distance,
      'address': address,
    };
  }
}
