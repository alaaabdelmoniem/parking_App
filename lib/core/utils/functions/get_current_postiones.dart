import 'dart:developer';
import 'package:geolocator/geolocator.dart';

Future<Position?> getCurrentLocation() async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    log('Location services are disabled.');
    return null;
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    return null;
  }

  try {
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
    log('current: ${position.latitude}, ${position.longitude}');
    return position;
  } catch (e) {
    log(e.toString());
    return null;
  }
}