import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/presentation/views/widgets/booking_widgets/spot_summary_section.dart';
import 'package:parking/features/map/presentation/views/widgets/booking_widgets/summary_header_section.dart';

class SummaryBookingViewBody extends StatelessWidget {
  const SummaryBookingViewBody({
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          const SummaryHeaderSection(),
          SpotSummarySection(
            spotModel: spotModel,
            startTime: startTime,
            endTime: endTime,
            duration: duration,
          ),
        ],
      ),
    );
  }
}
