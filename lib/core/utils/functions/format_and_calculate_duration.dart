import 'package:flutter/material.dart';

Duration calculateDuration(TimeOfDay start, TimeOfDay end) {
  final startMinutes = start.hour * 60 + start.minute;
  final endMinutes = end.hour * 60 + end.minute;

  var diffMinutes = endMinutes - startMinutes;

  //after midnight
  if (diffMinutes < 0) {
    diffMinutes += 24 * 60;
  }

  return Duration(minutes: diffMinutes);
}

String formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes % 60;

  if (hours == 0) {
    return '${minutes}m';
  }

  if (minutes == 0) {
    return '${hours}h';
  }

  return '${hours}h ${minutes}m';
}
