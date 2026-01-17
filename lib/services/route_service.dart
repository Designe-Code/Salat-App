import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class RouteService {
  /// Gets route polyline between two points
  /// Returns list of LatLng points for the route
  static Future<List<LatLng>> getRoute({
    required double startLat,
    required double startLon,
    required double endLat,
    required double endLon,
  }) async {
    try {
      // Using a simple straight line for now (free option)
      // For real routing, you'd need an API key for OpenRouteService or use Google Directions API
      // For now, we'll return a simple straight line between points
      return [
        LatLng(startLat, startLon),
        LatLng(endLat, endLon),
      ];
    } catch (e) {
      // Fallback to straight line if API fails
      return [
        LatLng(startLat, startLon),
        LatLng(endLat, endLon),
      ];
    }
  }

  /// Alternative: Get route using OSRM (Open Source Routing Machine) - completely free
  static Future<List<LatLng>> getRouteOSRM({
    required double startLat,
    required double startLon,
    required double endLat,
    required double endLon,
  }) async {
    try {
      final String url = 
          'http://router.project-osrm.org/route/v1/driving/$startLon,$startLat;$endLon,$endLat?overview=full&geometries=geojson';
      
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> routes = data['routes'] ?? [];
        
        if (routes.isNotEmpty) {
          final route = routes[0];
          final geometry = route['geometry'];
          final coordinates = geometry['coordinates'] as List<dynamic>;
          
          // Convert coordinates to LatLng (OSRM returns [lon, lat])
          return coordinates.map((coord) {
            return LatLng(coord[1].toDouble(), coord[0].toDouble());
          }).toList();
        }
      }
      
      // Fallback to straight line
      return [
        LatLng(startLat, startLon),
        LatLng(endLat, endLon),
      ];
    } catch (e) {
      // Fallback to straight line
      return [
        LatLng(startLat, startLon),
        LatLng(endLat, endLon),
      ];
    }
  }
}
