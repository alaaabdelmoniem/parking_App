import 'package:flutter/material.dart';
import 'package:parking/core/utils/app_colors.dart';

enum SpotStatus { plenty, moderate, fillingUp, almostFull, full }

class SpotStatusInfo {
  const SpotStatusInfo({
    required this.status,
    required this.label,
    required this.color,
  });

  final SpotStatus status;
  final String label;
  final Color color;
}

SpotStatusInfo getSpotStatus({
  required int availableSpots,
  required int totalCapacity,
}) {
  if (totalCapacity <= 0) {
    return const SpotStatusInfo(
      status: SpotStatus.full,
      label: 'Unavailable',
      color: AppColors.textTertiary,
    );
  }

  final ratio = availableSpots / totalCapacity;
  if (ratio <= 0) {
    return const SpotStatusInfo(
      status: SpotStatus.full,
      label: 'Full',
      color: AppColors.error,
    );
  } else if (ratio <= 0.15) {
    return const SpotStatusInfo(
      status: SpotStatus.almostFull,
      label: 'Almost full',
      color: AppColors.errorBright,
    );
  } else if (ratio <= 0.35) {
    return const SpotStatusInfo(
      status: SpotStatus.fillingUp,
      label: 'Filling up',
      color: AppColors.warning,
    );
  } else if (ratio <= 0.7) {
    return const SpotStatusInfo(
      status: SpotStatus.moderate,
      label: 'Available',
      color: AppColors.successDark,
    );
  } else {
    return const SpotStatusInfo(
      status: SpotStatus.plenty,
      label: 'Plenty of spots',
      color: AppColors.success,
    );
  }
}
