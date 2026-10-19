import 'dart:developer' show log;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:parking/core/utils/widgets/custom_floating_action_buttons.dart';
import 'package:parking/features/map/presentation/manager/cubits/fetch_spots/fetch_spots_cubit.dart';
import 'package:parking/features/map/presentation/views/widgets/rounded_sheet_content.dart';
import 'package:parking/features/map/presentation/views/widgets/search_text_field.dart';

class MapScreenBody extends StatefulWidget {
  const MapScreenBody({super.key});

  @override
  State<MapScreenBody> createState() => _MapScreenBodyState();
}

class _MapScreenBodyState extends State<MapScreenBody> {
  MapController mapController = MapController();

  // current location of the user
  Position? currentPosition;
  List<Marker> markers = [];
  Position? _lastFetchPosition;

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

    final lastKnown = await Geolocator.getLastKnownPosition();
    if (lastKnown != null) _handlePosition(lastKnown);

    // get a fresh fix without waiting for the user to move
    try {
      final fresh = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      _handlePosition(fresh);
    } catch (e) {
      log(e.toString());
    }

    // 3) Keep listening for movement
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      _handlePosition,
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

  // live inside the listener
  void _handlePosition(Position position) {
    if (!mounted) return;

    setState(() {
      currentPosition = position;
      markers
        ..removeWhere((m) => m.key == const ValueKey('current_location'))
        ..add(
          Marker(
            key: const ValueKey('current_location'),
            width: 80,
            height: 80,
            point: LatLng(position.latitude, position.longitude),
            child: const Icon(Icons.location_on, color: Colors.red, size: 40),
          ),
        );
    });

    // Fetch only on the first fix or after moving ~500 m.
    final last = _lastFetchPosition;
    final moved =
        last == null ||
        Geolocator.distanceBetween(
              last.latitude,
              last.longitude,
              position.latitude,
              position.longitude,
            ) >
            500;
    if (moved) {
      _lastFetchPosition = position;
      context.read<FetchSpotsCubit>().fetchSpots(
        lat: position.latitude,
        lng: position.longitude,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        currentPosition == null
            ? const Center(child: CupertinoActivityIndicator())
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
    );
  }
}
