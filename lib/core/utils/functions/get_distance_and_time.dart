//  it must be calculated at runtime, not persisted in the database.
import 'package:geolocator/geolocator.dart';

double getDistanceFrom(Position userPosition, double lat, double lng) {
  return Geolocator.distanceBetween(
    userPosition.latitude,
    userPosition.longitude,
    lat,
    lng,
  ); // returns distance in meters
}

String formatDistance(double distanceInMeters) {
  if (distanceInMeters >= 1000) {
    final km = distanceInMeters / 1000;
    return '${km.toStringAsFixed(1)} km';
  }
  return '${distanceInMeters.round()} m';
}

String formatDistanceAway(double distanceInMeters) {
  final miles = distanceInMeters / 1609.34;

  if (miles < 0.1) {
    final feet = distanceInMeters * 3.28084;
    return '${feet.round()} ft away';
  }

  return '${miles.toStringAsFixed(1)} mi away';
}

String formatWalkingTime(double distanceInMeters) {
  const walkingSpeedMetersPerMinute = 84.0; // ~5 km/h

  final minutes = distanceInMeters / walkingSpeedMetersPerMinute;

  if (minutes < 1) {
    return '< 1 min';
  }

  if (minutes < 60) {
    return '${minutes.round()} min';
  }

  final hours = minutes / 60;
  return '${hours.toStringAsFixed(1)} hr';
}
