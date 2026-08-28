import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class OpenStreetMapsTutorial extends StatefulWidget {
  const OpenStreetMapsTutorial({super.key});

  @override
  State<OpenStreetMapsTutorial> createState() => _OpenStreetMapsTutorialState();
}

class _OpenStreetMapsTutorialState extends State<OpenStreetMapsTutorial> {
  MapController mapController = MapController();

  // current location of the user
  Position? currentPosition;
  List<Marker> markers = [];
  // list of points to draw the route
  List<LatLng> routePoints = [];
  final orsApiKey = dotenv.env['ORS_API_KEY']!;

  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    // permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) {
        setState(() {
          currentPosition = position;

          // remove the old "current location" marker and add the updated one
          markers.removeWhere(
            (m) => m.key == const ValueKey('current_location'),
          );
          markers.add(
            Marker(
              key: const ValueKey('current_location'),
              height: 80,
              width: 80,
              point: LatLng(position.latitude, position.longitude),
              child: const Icon(Icons.location_on, color: Colors.red, size: 40),
            ),
          );
        });
      },
      onError: (e) {
        log(e.toString());
        if (mounted) {
          setState(() {
            currentPosition = null;
            markers.removeWhere(
              (m) => m.key == const ValueKey('current_location'),
            );
          });
        }
      },
    );
  }

  Future<void> _getRoute(LatLng destination) async {
    if (currentPosition == null) return;

    final start = LatLng(currentPosition!.latitude, currentPosition!.longitude);

    final url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}';

    try {
      final reponse = await Dio().get(url);
      final List<dynamic> coordinates =
          reponse.data['features'][0]['geometry']['coordinates'];
      if (!mounted) return;
      setState(() {
        routePoints = coordinates.map((p) => LatLng(p[1], p[0])).toList();
      });
    } catch (e) {
      print('Failed to get route: $e');
    }
  }

  void addDestinationMarker(LatLng point) {
    setState(() {
      // clear the previous destination marker and route before adding a new one
      markers.removeWhere((m) => m.key == const ValueKey('destination'));
      routePoints = [];
      markers.add(
        Marker(
          key: const ValueKey('destination'),
          height: 80,
          width: 80,
          point: point,
          child: const Icon(Icons.location_on, color: Colors.blue, size: 40),
        ),
      );
    });
    _getRoute(point);
  }

  void _zoomIn() {
    mapController.move(
      mapController.camera.center,
      mapController.camera.zoom + 1,
    );
  }

  void _zoomOut() {
    mapController.move(
      mapController.camera.center,
      mapController.camera.zoom - 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: LatLng(
                  currentPosition!.latitude,
                  currentPosition!.longitude,
                ),
                initialZoom: 15,
                onTap: (tapPosition, point) => addDestinationMarker(point),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png?api_key=cb1_257r_1_b4c8949f2fd291dcb7dfde6d',
                  subdomains: const ['a', 'b', 'c', 'd'],
                  userAgentPackageName: 'com.example.parking_app',
                ),

                MarkerLayer(markers: markers),
                if (routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: routePoints,
                        color: Colors.blue,
                        strokeWidth: 4,
                      ),
                    ],
                  ),
              ],
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            mini: true,
            heroTag: 'zoomIn',
            onPressed: _zoomIn,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            mini: true,
            heroTag: 'zoomOut',
            onPressed: _zoomOut,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            mini: true,
            heroTag: 'myLocation',
            onPressed: () {
              if (currentPosition != null) {
                mapController.move(
                  LatLng(currentPosition!.latitude, currentPosition!.longitude),
                  15,
                );
              }
            },
            child: const Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
