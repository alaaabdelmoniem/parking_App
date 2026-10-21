import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:parking/features/map/data/models/spot_model.dart';

class Directionsview extends StatefulWidget {
  const Directionsview({super.key, required this.spotModel});
  final SpotModel spotModel;
  @override
  State<Directionsview> createState() => _DirectionsviewState();
}

class _DirectionsviewState extends State<Directionsview> {
  MapController mapController = MapController();
  Position? _lastRoutePosition;
  int _routeRequestId = 0;

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
    addDestinationMarker();
  }

  Future<void> _getCurrentLocation() async {
    // 1) Location service (GPS) must be on
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Location services are disabled');
      return;
    }

    // 2) permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      log('Location permission denied: $permission');
      return;
    }

    // 3) Get a position right away (don't wait for the user to move 100 m)
    final lastKnown = await Geolocator.getLastKnownPosition();

    if (lastKnown != null) _setPosition(lastKnown);

    try {
      final fresh = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );
      _setPosition(fresh);
    } catch (e) {
      log('getCurrentPosition failed: $e');
    }

    // 4) Keep listening for movement
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      _setPosition,
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

  void _setPosition(Position position) {
    if (!mounted) return;
    setState(() {
      currentPosition = position;

      markers.removeWhere((m) => m.key == const ValueKey('current_location'));
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

    // Request the route on the first fix, then again after moving > 50 m
    final last = _lastRoutePosition;
    final moved =
        last == null ||
        Geolocator.distanceBetween(
              last.latitude,
              last.longitude,
              position.latitude,
              position.longitude,
            ) >
            50;

    if (moved) {
      _lastRoutePosition = position;
      _getRoute(LatLng(widget.spotModel.lat, widget.spotModel.lng));
    }
  }

  Future<void> _getRoute(LatLng destination) async {
    if (currentPosition == null) return;
    final requestId = ++_routeRequestId;

    final start = LatLng(currentPosition!.latitude, currentPosition!.longitude);

    final url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}';

    try {
      final reponse = await Dio().get(url);
      log('requestId=$requestId current=$_routeRequestId');
      final List<dynamic> coordinates =
          reponse.data['features'][0]['geometry']['coordinates'];

      // A newer request started while this one was loading: drop this result
      if (!mounted || requestId != _routeRequestId) return;

      setState(() {
        routePoints = coordinates.map((p) => LatLng(p[1], p[0])).toList();
      });
    } on DioException catch (e) {
      log('Failed to get route: ${e.response?.statusCode} ${e.response?.data}');
    } catch (e) {
      log('Failed to get route: $e');
    }
  }

  void addDestinationMarker() {
    setState(() {
      // clear the previous destination marker and route before adding a new one
      markers.removeWhere((m) => m.key == const ValueKey('destination'));
      routePoints = [];
      markers.add(
        Marker(
          key: const ValueKey('destination'),
          height: 80,
          width: 80,
          point: LatLng(widget.spotModel.lat, widget.spotModel.lng),
          child: const Icon(Icons.location_on, color: Colors.blue, size: 40),
        ),
      );
    });
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
          ? const Center(child: CupertinoActivityIndicator())
          : FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: LatLng(
                  currentPosition!.latitude,
                  currentPosition!.longitude,
                ),
                initialZoom: 15,
                // onTap: (tapPosition, point) => addDestinationMarker(point),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png?key=${dotenv.env['CARTO_API_KEY']}',
                  userAgentPackageName: 'com.example.parking',
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
