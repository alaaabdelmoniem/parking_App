import 'package:flutter/material.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/presentation/views/widgets/booking_widgets/summary_booking_view_body.dart';

class SummaryBookingView extends StatelessWidget {
  const SummaryBookingView({
    super.key,
    required this.spotModel,
    required this.startTime,
    required this.endTime,
    required this.duration,
  });
  final SpotModel spotModel;
  final DateTime startTime;
  final DateTime endTime;
  final int duration;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SummaryBookingViewBody(
        spotModel: spotModel,
        duration: duration,
        startTime: startTime,
        endTime: endTime,
      ),
    );
  }
}
