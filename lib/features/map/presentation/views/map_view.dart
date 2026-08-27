import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:parking/core/utils/widgets/custom_floating_action_buttons.dart';
import 'package:parking/features/map/presentation/views/widgets/rounded_sheet_content.dart';
import 'package:parking/features/map/presentation/views/widgets/search_text_field.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();

  // current location of the user
  Position? currentPosition;
  List<Marker> markers = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          currentPosition == null
              ? const Center(child: CircularProgressIndicator())
              : FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: LatLng(
                      currentPosition!.latitude,
                      currentPosition!.longitude,
                    ),
                    initialZoom: 15,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png?key=cb1_257r_1_b4c8949f2fd291dcb7dfde6d',
                      subdomains: const ['a', 'b', 'c', 'd'],
                      userAgentPackageName: 'com.example.parking_app',
                    ),

                    MarkerLayer(markers: markers),
                  ],
                ),

          // draggable bottom sheet
          const RoundedSheetContent(),
          const Positioned(
            top: 10,
            left: 16,
            right: 16,
            child: LocationSearchBar(),
          ),
          Positioned(
            right: 5.w,
            top: 85.h,
            child: CustomFloatingActionButtons(
              mapController: mapController,
              currentPosition: currentPosition,
            ),
          ),
        ],
      ),
    );
  }
}
