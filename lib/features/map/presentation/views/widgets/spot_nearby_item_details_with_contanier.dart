import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/presentation/views/widgets/parking_spot_details.dart';

class SpotNearbyItemWithContanier extends StatelessWidget {
  const SpotNearbyItemWithContanier({super.key, required this.spotModel});
  final SpotModel spotModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(24.r),
      ),
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 12.h),
      child: ParkingSpotDetails(spotModel: spotModel),
    );
  }
}
