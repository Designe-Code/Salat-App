import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:salati/models/mosque.dart';
import 'package:salati/services/mosque_service.dart';
import 'package:salati/services/route_service.dart';
import 'package:salati/providers/theme_provider.dart';
import 'package:salati/helper/theme.dart';
import 'package:salati/screen/widgets/mosque_map/mosque_search_bar.dart';
import 'package:salati/screen/widgets/mosque_map/mosque_marker_widget.dart';
import 'package:salati/screen/widgets/mosque_map/map_floating_buttons.dart';

class MosqueMapScreen extends StatefulWidget {
  const MosqueMapScreen({super.key});

  @override
  State<MosqueMapScreen> createState() => _MosqueMapScreenState();
}

class _MosqueMapScreenState extends State<MosqueMapScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  Position? _currentPosition;
  List<Mosque> _mosques = [];
  List<Mosque> _filteredMosques = [];
  bool _isLoading = true;
  String? _errorMessage;
  double _zoomLevel = 15.0;
  List<LatLng>? _routePolyline;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterMosques);
    _getCurrentLocationAndMosques();
  }

  void _filterMosques() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredMosques = _mosques;
      } else {
        _filteredMosques = _mosques
            .where((mosque) => mosque.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  Future<void> _getCurrentLocationAndMosques() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Check location permissions
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Location services are disabled. Please enable them to find nearby mosques.';
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Location permission denied. Please enable location access to find nearby mosques.';
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Location permissions are permanently denied. Please enable them in app settings.';
        });
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
      });

      // Fetch nearby mosques
      List<Mosque> mosques = await MosqueService.getNearbyMosques(
        latitude: position.latitude,
        longitude: position.longitude,
        radius: 2000, // 2km radius
      );

      setState(() {
        _mosques = mosques;
        _filteredMosques = mosques;
        _isLoading = false;
      });

      // Center map on user location
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _mapController.move(
          LatLng(position.latitude, position.longitude),
          _zoomLevel,
        );
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error loading mosques: ${e.toString()}';
      });
    }
  }

  Future<void> _centerOnMyLocation() async {
    if (_currentPosition != null) {
      _mapController.move(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        _zoomLevel,
      );
    } else {
      await _getCurrentLocationAndMosques();
    }
  }

  Future<void> _openDirections(Mosque mosque) async {
    if (_currentPosition == null) return;

    // Get route polyline
    try {
      final route = await RouteService.getRouteOSRM(
        startLat: _currentPosition!.latitude,
        startLon: _currentPosition!.longitude,
        endLat: mosque.latitude,
        endLon: mosque.longitude,
      );

      setState(() {
        _routePolyline = route;
      });

      // Also open in external maps app
      final String url = 'https://www.google.com/maps/dir/?api=1&destination=${mosque.latitude},${mosque.longitude}';
      final Uri uri = Uri.parse(url);
      
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Still try to open external maps even if route fails
      final String url = 'https://www.google.com/maps/dir/?api=1&destination=${mosque.latitude},${mosque.longitude}';
      final Uri uri = Uri.parse(url);
      
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
  }

  List<Marker> _buildMarkers() {
    List<Marker> markers = [];

    // Add user location marker
    if (_currentPosition != null) {
      markers.add(
        Marker(
          point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          child: const MosqueMarkerWidget(isUserLocation: true),
        ),
      );
    }

    // Add mosque markers (only filtered ones)
    for (var mosque in _filteredMosques) {
      markers.add(
        Marker(
          point: LatLng(mosque.latitude, mosque.longitude),
          child: GestureDetector(
            onTap: () {
              _showMosqueInfo(mosque);
            },
            child: const MosqueMarkerWidget(),
          ),
        ),
      );
    }

    return markers;
  }

  void _showMosqueInfo(Mosque mosque) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Mosque header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.mosque,
                    color: Theme.of(context).colorScheme.primary,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mosque.name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                      ),
                      if (mosque.distance != null)
                        Text(
                          '${(mosque.distance! / 1000).toStringAsFixed(1)} km away',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (mosque.address != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade300.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        mosque.address!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _mapController.move(
                        LatLng(mosque.latitude, mosque.longitude),
                        _zoomLevel,
                      );
                    },
                    icon: const Icon(Icons.center_focus_strong),
                    label: const Text('View on Map'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _openDirections(mosque);
                    },
                    icon: const Icon(Icons.directions),
                    label: const Text('Directions'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  String _getMapTileUrl() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDark = themeProvider.themeData == darkMode;
    
    // Use CartoDB dark tiles for dark mode, OpenStreetMap for light mode
    if (isDark) {
      return 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png';
    } else {
      return 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.themeData == darkMode;
        
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            title: const Text('Nearby Mosques'),
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: 0,
            centerTitle: true,
          ),
          body: _isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Loading nearby mosques...',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                )
              : _errorMessage != null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red.shade300,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _errorMessage!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: _getCurrentLocationAndMosques,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Retry'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        // Search bar
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: MosqueSearchBar(
                            controller: _searchController,
                            onChanged: (_) => _filterMosques(),
                            onClear: () {
                              _searchController.clear();
                            },
                          ),
                        ),
                        // Map container with border radius
                        Positioned(
                          top: 80,
                          left: 16,
                          right: 16,
                          bottom: 16,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: FlutterMap(
                              mapController: _mapController,
                              options: MapOptions(
                                initialCenter: _currentPosition != null
                                    ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                                    : const LatLng(0, 0),
                                initialZoom: _zoomLevel,
                                minZoom: 10.0,
                                maxZoom: 18.0,
                                interactionOptions: const InteractionOptions(
                                  flags: InteractiveFlag.all,
                                ),
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate: _getMapTileUrl(),
                                  userAgentPackageName: 'com.salati.app',
                                  subdomains: isDark ? ['a', 'b', 'c', 'd'] : ['a', 'b', 'c'],
                                ),
                                // Route polyline layer
                                if (_routePolyline != null && _routePolyline!.isNotEmpty)
                                  PolylineLayer(
                                    polylines: [
                                      Polyline(
                                        points: _routePolyline!,
                                        strokeWidth: 4.0,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ],
                                  ),
                                MarkerLayer(
                                  markers: _buildMarkers(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Floating action buttons
                        Positioned(
                          right: 32,
                          bottom: 32,
                          child: MapFloatingButtons(
                            onRefresh: _getCurrentLocationAndMosques,
                            onMyLocation: _centerOnMyLocation,
                          ),
                        ),
                        // Mosque count badge
                        if (_filteredMosques.isNotEmpty)
                          Positioned(
                            bottom: 32,
                            left: 32,
                            right: 100,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.mosque,
                                      color: Theme.of(context).colorScheme.primary,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    '${_filteredMosques.length} found',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mapController.dispose();
    super.dispose();
  }
}
