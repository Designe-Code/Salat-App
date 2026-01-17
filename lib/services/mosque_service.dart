import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:salati/models/mosque.dart';

class MosqueService {
  // Overpass API endpoint (free, no API key required)
  static const String _overpassApiUrl = 'https://overpass-api.de/api/interpreter';

  /// Fetches nearby mosques within specified radius
  /// 
  /// [latitude] and [longitude] are the user's current location
  /// [radius] is the search radius in meters (default: 2000m = 2km)
  static Future<List<Mosque>> getNearbyMosques({
    required double latitude,
    required double longitude,
    double radius = 2000.0,
  }) async {
    try {
      // Overpass QL query to find mosques (place_of_worship with religion=muslim)
      final String query = '''
[out:json][timeout:25];
(
  node["amenity"="place_of_worship"]["religion"="muslim"](around:$radius,$latitude,$longitude);
  way["amenity"="place_of_worship"]["religion"="muslim"](around:$radius,$latitude,$longitude);
  relation["amenity"="place_of_worship"]["religion"="muslim"](around:$radius,$latitude,$longitude);
);
out body;
>;
out skel qt;
''';

      final Uri uri = Uri.parse('$_overpassApiUrl?data=${Uri.encodeComponent(query)}');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> elements = data['elements'] ?? [];

        List<Mosque> mosques = [];

        for (var element in elements) {
          // Handle nodes (points)
          if (element['type'] == 'node' && element['lat'] != null && element['lon'] != null) {
            final mosqueLat = element['lat']?.toDouble() ?? 0.0;
            final mosqueLon = element['lon']?.toDouble() ?? 0.0;
            // Calculate distance from user location
            final distance = Geolocator.distanceBetween(
              latitude,
              longitude,
              mosqueLat,
              mosqueLon,
            );
            
            // Try multiple name variations
            final tags = element['tags'] ?? {};
            final name = tags['name'] ?? 
                        tags['name:en'] ?? 
                        tags['name:ar'] ?? 
                        tags['name:fr'] ?? 
                        tags['official_name'] ??
                        tags['alt_name'] ??
                        'Mosque';
            
            final mosque = Mosque(
              name: name,
              latitude: mosqueLat,
              longitude: mosqueLon,
              distance: distance,
              address: tags['addr:full'] ?? 
                       tags['addr:street'] ?? 
                       tags['address'] ??
                       (tags['addr:housenumber'] != null && tags['addr:street'] != null
                         ? '${tags['addr:housenumber']} ${tags['addr:street']}'
                         : null),
            );
            mosques.add(mosque);
          }
          // Handle ways (areas) - get center point
          else if (element['type'] == 'way' && element['center'] != null) {
            final center = element['center'];
            final mosqueLat = center['lat']?.toDouble() ?? 0.0;
            final mosqueLon = center['lon']?.toDouble() ?? 0.0;
            // Calculate distance from user location
            final distance = Geolocator.distanceBetween(
              latitude,
              longitude,
              mosqueLat,
              mosqueLon,
            );
            
            // Try multiple name variations
            final tags = element['tags'] ?? {};
            final name = tags['name'] ?? 
                        tags['name:en'] ?? 
                        tags['name:ar'] ?? 
                        tags['name:fr'] ?? 
                        tags['official_name'] ??
                        tags['alt_name'] ??
                        'Mosque';
            
            final mosque = Mosque(
              name: name,
              latitude: mosqueLat,
              longitude: mosqueLon,
              distance: distance,
              address: tags['addr:full'] ?? 
                       tags['addr:street'] ?? 
                       tags['address'] ??
                       (tags['addr:housenumber'] != null && tags['addr:street'] != null
                         ? '${tags['addr:housenumber']} ${tags['addr:street']}'
                         : null),
            );
            mosques.add(mosque);
          }
        }

        // Sort by distance (nearest first)
        mosques.sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));

        return mosques;
      } else {
        throw Exception('Failed to load mosques: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching mosques: $e');
    }
  }
}
